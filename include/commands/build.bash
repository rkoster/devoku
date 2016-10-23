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

	touch $local_import_tar $local_cache_tar $local_slug_tar
	declare commit=`(git rev-parse HEAD)`;
	echo "Using local commit $commit" | indent;
	git archive --output=$local_import_tar $commit

	title "Building slug"
  docker run \
		--rm \
		-v $local_import_tar:$container_import_tar \
		-v $local_cache_tar:$container_cache_tar \
		-v $local_slug_tar:$container_slug_tar \
		-v $local_env_file:$container_env_file \
		$herokuish_image \
		bin/bash -c \
			"source $container_env_file \
			&& mkdir -p /tmp/app /tmp/cache \
			&& if [ -s $container_cache_tar ]; then tar -xzf $container_cache_tar -C /tmp/cache; fi \
			&& tar -xzf $container_import_tar -C /tmp/app \
			&& USER=herokuishuser /bin/herokuish buildpack build \
			&& tar -czf $container_cache_tar -C /tmp/cache . \
			&& USER=herokuishuser IMPORT_PATH=/nosuchpath /bin/herokuish slug generate \
			&& USER=herokuishuser /bin/herokuish slug export > $container_slug_tar"

	title "Building Docker image"
	echo "Importing slug" | indent
	docker run \
		-i \
		--name $identifier \
		$herokuish_image \
    bin/bash -c \
      "USER=herokuishuser /bin/herokuish slug import <&0" < $local_slug_tar

	echo "Writing new Docker image" | indent
	docker commit $identifier $identifier/$identifier:latest &> /dev/null || true
	echo "Cleaning up" | indent
	docker rm -f -v $identifier &> /dev/null || true
}

clean() {
	remove-dirs
	ensure-dirs
}
