Full command reference.

!!! Note "Check your cwd"
    Make sure you are executing your command in the right cwd, by default this is /vagrant.

## build

Builds a Docker image based upon your latest commit.

```
$ devoku build
```

## env new

Creates a new environment, this will set environment variables for your App. By
default it creates a randomly generated:

- DATABASE_URL
- REDIS_URL
- S3_BUCKET

```
$ devoku env new
```

## env set

Append to the current environment.

```
$ devoku env new <VARIABLE>=<VALUE>
```

## env print

Prints out the current environment.

```
$ devoku env print
```

## web

Runs a web instance according to your Procfile. This immediately attaches to
the Docker container's log. This Docker container keeps running, until either:

- The command is run again
- You exit the docker container manually by running: `docker kill devoku-web`

```
$ devoku web
```

## worker

Runs a worker instance according to your Procfile. See the `devoku web` command for
more information.

```
$ devoku worker
```

## run

Runs the given command inside a Docker container. You can use stdin and stdout for
reading and writing.

```
$ devoku run <COMMAND>
```

Starts an interactive shell inside a Docker container.

## shell

```
$ devoku shell
```

## pg createdb

Creates the database as configured in your environment's `DATABASE_URL`.

```
$ devoku pg createdb
```

## pg dropdb

Drops the database as configured in your environment's `DATABASE_URL`.

```
$ devoku pg dropdb
```

## pg psql

Starts an interactive psql session against your the database nfigured in your environment's `DATABASE_URL`.

```
$ devoku pg psql
```

## service up

Installs and runs the specified service. Valid choices are:

- postgres
- redis
- s3

```
$ devoku service <name> up
```

## service down

Completely removes the specfied service.

```
$ devoku service <name> down
```
