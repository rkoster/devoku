check-env() {
  if [ ! -f "$local_env_file" ]; then
    echo >&2 "Env is not configured"
    exit 10
  fi
}

env-template() {
  eval "echo \"$(cat $env_template_file)\""
}

env-new() {
	declare desc="Create a new environment"
	declare unique=$(cat /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)
	ensure-dirs
	title "Creating new environment"
	env-template > $local_env_file
}

env-set() {
	declare desc="Set environment variables"
	for var in "$@"
	do
		tee -a $local_env_file > /dev/null <<EOF
export $var
EOF
	done
}

env-print() {
	declare desc="Print environment variables"
  ensure-dirs
  check-env
  cat $local_env_file
}
