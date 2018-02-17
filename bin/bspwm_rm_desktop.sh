#!/bin/bash

# from: https://blog.codezen.org/2015/03/13/on-bspwm-tweaking/  

DMENU_NF="#A3A6AB"
DMENU_NB="#34322E"
DMENU_SF="#F6F9FF"
DMENU_SB="#5C5955"

DESKTOP_NAME=`bspc query -D --names | dmenu -nf "$DMENU_NF" -nb "$DMENU_NB" -sf "$DMENU_SF" -sb "$DMENU_SB" -p 'Desktop:'`

if [ -z $DESKTOP_NAME ]; then
    exit 0
fi

bspc desktop "$DESKTOP_NAME" -r
