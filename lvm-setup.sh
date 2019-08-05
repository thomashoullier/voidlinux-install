#!/bin/sh
# Setup the LVM partition with LUKS and swap+root partitions.
# We assume the LVM partition is the second on the device, in line with the rest
# of the installation process.
# Input:
# 1. Device, eg. "/dev/sda"

echo "$1"2
