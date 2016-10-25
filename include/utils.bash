title() {
	echo $'\e[1G----->' $*
}

indent() {
	while read line; do
		if [[ "$line" == --* ]] || [[ "$line" == ==* ]]; then
			echo $'\e[1G'$line
		else
			echo $'\e[1G      ' "$line"
		fi
	done
}

long-running()
{
    local pid=$1
    local delay=0.25
    local spin=('\xe2\xa3\xbe' '\xe2\xa3\xb7' '\xe2\xa3\xaf' '\xe2\xa3\x9f' '\xe2\xa1\xbf' '\xe2\xa2\xbf' '\xe2\xa3\xbb' '\xe2\xa3\xbd')
		echo -ne "$2  "

		# If this script is killed, kill the process
		trap "kill $pid 2> /dev/null" EXIT

    while kill -0 $pid 2> /dev/null; do
			for i in "${spin[@]}"
		  do
        echo -e "\b\e[92m$i\e[39m"
        sleep $delay
		  done
    done

		# Disable the trap on a normal exit.
		trap - EXIT

		echo -e "\b\e[92m[DONE]\e[39m"
}
