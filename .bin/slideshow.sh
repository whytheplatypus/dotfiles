#!/bin/sh

PID_FILE="$HOME/.slideshow.pid"

# track pid file
# if exists kill
pkill -F $PID_FILE
rm $PID_FILE

# parse gif

# More meaningful argument names
GIF_PATH=${@: -1}

if [[ ! $GIF_PATH =~ \.gif$ ]]; then
	echo "No gif or images found.  Exiting now $GIF_PATH"
	/usr/bin/feh $@
	exit
fi

GIF_NAME=`basename -s .gif $GIF_PATH`
GIF_DIR="$HOME/.config/slideshow/$GIF_NAME"

if [[ ! -d $GIF_DIR ]]; then
	mkdir -p $GIF_DIR
	identify -format "%s\n%T\n" $GIF_PATH > $GIF_DIR/frames
	#rm $GIF_DIR/*.png
	convert -coalesce $GIF_PATH $GIF_DIR/gif.png
fi


# create folder of pngs

readarray -t frames < $GIF_DIR/frames

render(){
	COUNTER=0
	while : 
	do
		speed=`echo "scale=3; ${frames[COUNTER+1]} / 100" | bc`
		# Increment counter and reset
		/usr/bin/feh --bg-fill $GIF_DIR/gif-${frames[COUNTER]}.png
		sleep $speed
		COUNTER=$(($COUNTER + 2))
		if [ $COUNTER -ge ${#frames[@]} ]; then
		  COUNTER=0
		fi
	done
}

render &
echo $! > $PID_FILE

disown $!
