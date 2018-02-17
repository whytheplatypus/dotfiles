#!/usr/bin/env bash
# credit: https://raw.githubusercontent.com/sector-f/admiral/master/admiral.d/bspwm_workspaces.sh

source ${HOME}/.wallpapers/current.sh

FREE=$color0
OCCUPIED=$color3
FOCUSED=$color2
URGENT=$color7
DESKTOP_ROW=1
MAX_DESKTOPS=9

if ! type bspc &> /dev/null; then
	echo "bspc not found"
	exit 1
fi

while read -r line; do
	case $line in
		W*)
			IFS=':'
			set -- ${line#?}
			count=1
			while [ $# -gt 0 ]; do
				item="$1"
				name="${item#?}"
				case $item in
					f*)
						# free desktop
						(( count++ ))
						echo -n "$count:$DESKTOP_ROW:$FREE,"
						;;
					F*)
						# focused free desktop
						(( count++ ))
						echo -n "$count:$DESKTOP_ROW:$FOCUSED,"
						;;
					o*)
						# occupied desktop
						(( count++ ))
						echo -n "$count:$DESKTOP_ROW:$OCCUPIED,"
						;;
					O*)
						# focused occupied desktop
						(( count++ ))
						echo -n "$count:$DESKTOP_ROW:$FOCUSED,"
						;;
					u*)
						# urgent desktop
						(( count++ ))
						echo -n "$count:$DESKTOP_ROW:$URGENT,"
						;;
					U*)
						# focused urgent desktop
						(( count++ ))
						echo -n "$count:$DESKTOP_ROW:$FOCUSED,"
						;;
					LM)
						# focused urgent desktop
						echo -n "m:red,"
						;;
					LT)
						# focused urgent desktop
						echo -n "m:green,"
						;;
				esac
				shift
			done
			while [ $count -lt $MAX_DESKTOPS ]; do
				(( count++ ))
				echo -n "$count:$DESKTOP_ROW:black,"
			done
	esac
	echo
done < <(bspc subscribe report) > $LIGHTS_FIFO

