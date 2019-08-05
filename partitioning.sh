#!/bin/sh
# Partitioning the requested disk
# The partition table to use is parametered in sfdisk-partitions.dat
# I:
# 1: Device to use, eg. "/dev/sda"

sudo sfdisk --delete "$1"
sudo cat sfdisk-partitions.dat | sudo sfdisk "$1"
