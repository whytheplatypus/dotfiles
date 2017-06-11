# Arch
Update: `sudo pacman -Syu`
Toggle trackpad: `alt + space`
Save package list: `pacman -Qet > pacman .txt`

# Network
`nmtui-connect`

or

`nmcli dev wifi connect <name> password <password>`

## VPN
```
pia -l # lists config optios
openvpn --config /etc/openvpn/client/<config_option.conf>
OR
nmtui-connect
```

# urxvt
- switch font: `ctrl + <9,0,-,=>`

# Development
Mounting a usb for development:
```
sudo mount /dev/sdb1 /mnt/dev -o uid=whytheplatypus
```
This allows even go development with `ln -s /mnt/dev/whatever $GOPATH/whatever`

# Time
ntpd -qg
hwclock --systohc

# Bluetooth audio
```
bluetoothctl
power on
connect <device>
```
Might also have to enable the service

If sound is bad
```
pacmd set-card-profile 2 a2dp_sink
```


# NFS

Show possibilities
```
showmount -e <server>
sudo mount <server>:<server path> <local path>
```

# Screens xrandr
`xrandr --output DP1 --auto --above eDP1`
xrandr set the output <output name> automatically above <other output name>

