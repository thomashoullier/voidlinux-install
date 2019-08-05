#!/bin/sh
# Void installation. Calls other sub-scripts.
# Inputs:
# 1.: Device on which Void Linux must be installed, eg. "/dev/sda"
# 2.: Volume group name for the new LVM, eg "void".

./partitioning.sh "$1"
./lvm-setup.sh "$1" "$2"
