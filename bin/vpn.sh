#!/bin/sh

VPN_NAME="US East"

if nmcli con show --active | grep "$VPN_NAME"; then
	nmcli con down id "$VPN_NAME"
else
	nmcli con up id "$VPN_NAME"
fi
