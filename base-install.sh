#!/bin/sh
# Basic system installation
# Inputs:
# 1. Device. Eg. "/dev/sda"
# 2. Volume groupe name. Eg. "void"
# 3. Hostname.
# 4. Boot partition label. Must be locally unique.

wget https://alpha.de.repo.voidlinux.org/static/xbps-static-latest.x86_64-musl.tar.xz
sudo tar xf xbps-static-latest.x86_64-musl.tar.xz -C /mnt
sudo /mnt/usr/bin/xbps-install \
-S --repository=https://alpha.de.repo.voidlinux.org/current \
-r /mnt base-system lvm2 cryptsetup grub-x86_64-efi

#Clean-up the downloaded tarball
sudo rm xbps-static-latest.x86_64-musl.tar.xz

# Mount some directories before chrooting
sudo mkdir -p /mnt/dev
sudo mkdir -p /mnt/proc
sudo mkdir -p /mnt/sys
sudo mount -t proc /proc /mnt/proc
sudo mount --rbind /dev /mnt/dev
sudo mount --rbind /sys /mnt/sys

# Configure system files
sudo cp -f rc.conf /mnt/etc/rc.conf

echo "$3" | sudo tee /mnt/etc/hostname > /dev/null

echo "hostonly=yes" | sudo tee /mnt/etc/dracut.conf.d/hostonly.conf > /dev/null

sudo cp -f grub /mnt/etc/default/grub

sudo cp -f libc-locales /mnt/etc/default/libc-locales

sudo mkdir /mnt/boot/grub

# The UUID and PARTUUID is changed on first boot. We use a LABEL.
echo "tmpfs /tmp tmpfs defaults,nosuid,nodev 0 0" | sudo tee /mnt/etc/fstab \
> /dev/null
echo "LABEL=$4 /boot vfat defaults 0 2" \
| sudo tee -a /mnt/etc/fstab > /dev/null
echo "/dev/mapper/$2-root / ext4 defaults,noatime 0 1" | sudo tee -a \
/mnt/etc/fstab > /dev/null
echo "/dev/mapper/$2-swap none swap defaults 0 1" | sudo tee -a /mnt/etc/fstab \
> /dev/null

# Unmounting the boot partition to write the label
sudo umount "$1"1
sudo fatlabel "$1"1 "$4"
sudo mount "$1"1 /mnt/boot

# Chroot and run final configuration script:
sudo cp -f chroot-script.sh /mnt/home/chroot-script.sh
sudo chroot /mnt /bin/bash -c "/bin/sh /home/chroot-script.sh"

