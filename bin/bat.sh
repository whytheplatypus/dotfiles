#!/usr/bin/env bash

LOW=$color0
MEDIUM=$color3
FINE=$color2
regex="[0-9]*%"

if ! type acpi &> /dev/null; then
	echo "acpi not found"
	exit 1
fi

bat=$(acpi -b)
ac=$(acpi -a)

echo $bat $ac

echo -n "a:" > $LIGHTS_FIFO
if [[ $ac == *"on-line"* ]]; then
	echo "plugged in"
	echo "green" > $LIGHTS_FIFO
else
	echo "unplugged"
	echo "red" > $LIGHTS_FIFO
fi

if [[ $bat =~ $regex ]]; then
	left=$(echo $bat | grep -o '[0-9]*%' | grep -o '[0-9]*')
	echo "left" $left
	echo -n "b:" > $LIGHTS_FIFO
	if [ $left -gt "50" ]; then
		echo "green" > $LIGHTS_FIFO
	elif [ $left -gt "20" ]; then
		echo "yellow" > $LIGHTS_FIFO
	else
		echo "red" > $LIGHTS_FIFO
	fi
fi
