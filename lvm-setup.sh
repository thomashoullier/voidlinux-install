#!/bin/sh
# Setup the LVM partition with LUKS and swap+root partitions.
# We assume the LVM partition is the second on the device, in line with the rest
# of the installation process.
# The default swap size is 16G, which is the amount of RAM we have on our
# machine. If you need more disk space and are confident you won't need as much
# SWAP then you can modify this.
# Input:
# 1. Device, eg. "/dev/sda"
# 2. Volume group name. Must be different from existing volume groups on the
#    system. eg "void"

sudo cryptsetup luksFormat "$1"2
sudo cryptsetup luksOpen "$1"2 new-voidvm

sudo pvcreate /dev/mapper/new-voidvm
sudo vgcreate "$2" /dev/mapper/new-voidvm
sudo lvcreate --name swap -L 16G "$2"
sudo lvcreate --name root -l 100%FREE "$2"

sudo mkfs.fat -F32 "$1"1
sudo mkfs.ext4 /dev/mapper/"$2"-root
sudo mkswap /dev/mapper/"$2"-swap
sudo swapon /dev/mapper/"$2"-swap

sudo mount /dev/mapper/"$2"-root /mnt
sudo mkdir /mnt/boot
sudo mount "$1"1 /mnt/boot

