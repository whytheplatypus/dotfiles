# Arch
Update: `sudo pacman -Syu`
Toggle trackpad: `alt + space`
Save package list: `pacman -Qet > pacman .txt`

# Network
`nmtui-connect`

or

`nmcli dev wifi connect <name> password <password>`

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
