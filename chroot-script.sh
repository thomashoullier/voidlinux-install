#!/bin/sh
# Script to be executed while chrooted in the new Void Linux.
# You must be chrooted as root.

# Define new root password
passwd root
chown root:root /
chmod 755 /

mkdir /boot/EFI
grub-mkconfig -o /boot/grub/grub.cfg
grub-install --target=x86_64-efi --efi-directory=/boot --removable --no-nvram

xbps-reconfigure -f glibc-locales

linuxver=$(uname -r | awk -F. '{print $1 FS $2}')
xbps-reconfigure -f linux"$linuxver"

