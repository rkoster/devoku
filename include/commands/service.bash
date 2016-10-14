service-postgres-up() {
  declare desc="Run the PostgreSQL service"
  docker run \
    --name $identifier-postgres \
    --restart always \
    -e POSTGRES_PASSWORD=$identifier \
    -e POSTGRES_USER=$identifier \
    -d \
    --net host \
    $postgres_image
}

service-redis-up() {
  declare desc="Run the Redis service"
  docker run \
    --name $identifier-redis \
    --restart always \
    -d \
    --net host \
    $redis_image
}

service-s3-up() {
  declare desc="Run the Fake S3 service"
  docker run \
    --name $identifier-s3 \
    --restart always \
    -d \
    --net host \
    $fake_s3_image
}

service-down() {
  docker rm -f -v $1 &> /dev/null || true
}

service-redis-down() {
  declare desc="Destroy the Redis service"
  service-down $identifier-redis
}

service-postgres-down() {
  declare desc="Destroy the PostgreSQL service"
  service-down $identifier-postgres
}

service-s3-down() {
  declare desc="Destroy the Fake S3 service"
  service-down $identifier-s3
}
