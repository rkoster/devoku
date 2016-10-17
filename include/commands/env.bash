env-template() {
  eval "echo \"$(cat $env_template_file)\""
}

env-new() {
	declare desc="Create a new environment"
	declare unique=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)
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
	echo `cat $local_env_file`
}
