#!/bin/sh
# Void installation. Calls other sub-scripts.
# Inputs:
# 1.: Device on which Void Linux must be installed, eg. "/dev/sda"

./partitioning.sh "$1"
./lvm-setup.sh "$1"
