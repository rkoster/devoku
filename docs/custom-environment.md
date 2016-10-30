Devoku's environment management features serve 2 functions:

- Quickly create a new environment without having to figure out all variables over and over again.

- Allow customization specific to a development environment.

In this topic we will cover the environment template file, and some common scenario's and solutions to create your perfect development environment.

## Template file location

During execution of the `devoku env new` command, Devoku looks for a template file named `.env.template` inside your cwd. If none is found, it will use the default template provided with Devoku.

## Default template file

```
export DATABASE_URL=postgres://$identifier:$identifier@localhost:5432/$unique
export REDIS_URL=redis://localhost:6379
export S3_BUCKET=$unique
export AWS_ACCESS_KEY_ID=$identifier
export AWS_SECRET_ACCESS_KEY=$identifier
```

## Template variables

- $unique: a randomly generated string.
- $identifier: defaults to `devoku`.
- $container_share_dir: path to the Docker volume for the cwd, defaults to `/devoku/share`.

## Runtime variables

- $DEVOKU_CONTEXT: either `run` or `build`.

## Escaping

Template files are interpreted using bash itself, so if your template files want to
make use of runtime variables and strings, these will need to be escaped as such:

```
\"\$DEVOKU_CONTEXT\" == \"run\"
```

## Examples

### Mount cwd for live editing

```
if [ \"\$DEVOKU_CONTEXT\" == \"run\" ]; then
  for path in \$(cd $container_share_dir/ && ls -d *); do
    rm -rf /app/\$path
    ln -s $container_share_dir/\$path /app/\$path
  done
fi
```
