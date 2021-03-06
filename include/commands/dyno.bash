declare run_args="\
--net host \
-v $local_share_dir:$container_share_dir \
-v $local_env_file:$container_env_file \
$identifier/$identifier:latest"

dyno-run() {
  declare desc="Run command inside a Herokuish container"
  declare cmd="$@"
  if [ -z "$cmd" ]; then
    echo >&2 "No command given"
    exit 1
  fi

  check-docker
  check-env
  docker run \
    --rm -i \
    $run_args \
    bin/bash -c \
      "DEVOKU_CONTEXT=run source $container_env_file \
      ;USER=herokuishuser /bin/herokuish procfile exec $cmd"
}

dyno-shell() {
  declare desc="Start a shell inside a Herokuish container"
  check-docker
  check-env
  docker run \
    --rm -it \
    -e PORT=$port \
    $run_args \
    bin/bash -c \
      "DEVOKU_CONTEXT=run source $container_env_file \
      ;USER=herokuishuser /bin/herokuish procfile exec /bin/bash"
}

dyno-process() {
  declare desc="Run Herokuish procfile process"
  declare process="${1:-web}"
  declare name="$identifier-$process"
  check-docker
  check-env
  docker rm -f -v $name &> /dev/null || true
  declare container=`docker run \
		-d --name $name \
    -e PORT=$port \
		 $run_args \
		bin/bash -c \
			"DEVOKU_CONTEXT=run source $container_env_file \
			;USER=herokuishuser /bin/herokuish procfile start $process"`
  docker logs -f $name
}

dyno-web() {
  declare desc="Run Herokuish web process"
  dyno-process "web"
}

dyno-worker() {
  declare desc="Run Herokuish worker process"
  dyno-process "worker"
}
