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

for existing_desktop in `bspc query -D`; do
    if [ "$DESKTOP_NAME" == "$existing_desktop" ]; then
        bspc desktop "$DESKTOP_NAME" -m `bspc query -M -m focused`
        bspc desktop -f "$DESKTOP_NAME"
        exit 0
    fi
done

bspc monitor -a "$DESKTOP_NAME"
bspc desktop -f "$DESKTOP_NAME"
