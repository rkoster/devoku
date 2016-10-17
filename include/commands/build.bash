build() {
	declare desc="Build the Herokuish Docker image"
	check-docker
	check-env
	check-git
	ensure-dirs

	title "Starting build"
	echo "Removing stale Docker containers and images" | indent
	docker rm -f -v $identifier &> /dev/null || true
	docker rmi -f $identifier/$identifier:latest &> /dev/null || true

	declare commit=`(git rev-parse HEAD)`
	echo "Using local commit $commit" | indent
	rm -rf $local_app_dir
	mkdir -p $local_app_dir
	git archive --format=tar $commit | (cd $local_app_dir/ && tar xf -)

	title "Building slug"
	touch $local_slug_file
  docker run \
		--rm \
		-v $local_slug_file:$container_slug_file \
		-v $local_app_dir:/tmp/app \
		-v $local_cache_dir:/tmp/cache \
		-v $local_env_file:$container_env_file \
		$herokuish_image \
		bin/bash -c \
			"source $container_env_file \
			;USER=herokuishuser /bin/herokuish buildpack build \
			&& USER=herokuishuser IMPORT_PATH=/nosuchpath /bin/herokuish slug generate \
			&& USER=herokuishuser /bin/herokuish slug export > $container_slug_file"

	title "Building Docker image"
	echo "Importing slug" | indent
	docker run \
		-i \
		--name $identifier \
		$herokuish_image \
    bin/bash -c \
      "USER=herokuishuser /bin/herokuish slug import <&0" < $local_slug_file

	echo "Writing new Docker image" | indent
	docker commit $identifier $identifier/$identifier:latest &> /dev/null || true
	echo "Cleaning up" | indent
	docker rm -f -v $identifier &> /dev/null || true
}

clean() {
	remove-dirs
	ensure-dirs
}
