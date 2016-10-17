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
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
			for i in "${spin[@]}"
		  do
        echo -ne "\b\e[92m$i\e[39m"
        sleep $delay
		  done
    done
		echo -e "\b\e[92m[DONE]\e[39m"
}
