#!/usr/bin/env bash

# credit: https://raw.githubusercontent.com/sector-f/admiral/master/admiral.d/bspwm_workspaces.sh

if ! type cava &> /dev/null; then
	echo "cava not found"
	exit 1
fi

max=6

while read -r line; do
	IFS=';'
	set -- ${line#?}
	while [ $# -gt 0 ]; do
		height=$1
	if [ -n "$height" ]
	then
		for ((number = $max; number >= $max-$height; number--))
		do
		echo -n "$#:$number:purple,"
		done
		for ((blank = 0; blank < $max-$height; blank++))
		do
		echo -n "$#:$blank:black,"
		done	
	fi
		shift
	done
	echo
done < <(cava -p ./config)
 
