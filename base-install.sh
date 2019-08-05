#!/bin/sh
# Basic system installation
# Inputs:
# 1. Device. Eg. "/dev/sda"

wget https://alpha.de.repo.voidlinux.org/static/xbps-static-latest.x86_64-musl.tar.xz
sudo tar xf xbps-static-latest.x86_64-musl.tar.xz -C /mnt
sudo /mnt/usr/bin/xbps-install \
-S --repository=https://alpha.de.repo.voidlinux.org/current \
-r /mnt base-system lvm2 cryptsetup grub-x86_64-efi

#Clean-up the downloaded tarball
sudo rm xbps-static-latest.x86_64-musl.tar.xz

# Mount some directories before chrooting
sudo mkdir /mnt/dev
sudo mkdir /mnt/proc
sudo mkdir /mnt/sys
sudo mount -t proc /proc /mnt/proc
sudo mount --rbind /dev /mnt/dev
sudo mount --rbind /sys /mnt/sys

# Get the UUID of the EFI partition.
uuid=$(blkid -o value -s UUID "$1"1)

# Configure system files
sudo cp -f rc.conf /mnt/etc/rc.conf

