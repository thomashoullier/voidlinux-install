# Void Linux installation and configuration
We write a series of scripts to install a Void Linux session from another
Linux distribution.

## Dependencies
To run the scripts, you need:
* `sfdisk`: A scriptable version of `fdisk`.
* `cryptsetup`: To configure the encrypted LVM LUKS partition.
* `wget`
* `mkfs.fat`, `mkswap` and `mkfs.ext4`.

## Usage
Just run:

```shell
./void-install.sh /dev/sdx voidvm host bootlabel
```

Replacing:
* **/dev/sdx** with the device on which Void Linux must be installed.
* **voidvm** with the name of the volume group you want to use. Must not already
be present on the machine you are using to perform the installation.
* **host** hostname to use for the new machine.
* **bootlabel** with a *locally unique* `LABEL` used in `/etc/fstab`. Must be
11 bytes or shorter.

You end up with a fully functional Void Linux installation. This of course is
pretty minimal in itself (at least compared with bloated Linux distributions).
You can refer to [2] if you have no idea what to do next.

## Partioning
We use an encrypted `root`. We do not have the need for encrypted boot
currently. The template we use on the disk is:
* Boot: 512M
* LVM LUKS
  * Swap: 16G
  * Root: The rest of disk space.

## GRUB
We use `grub2` as the bootloader. The newly configured disk is treated as
removable to avoid interactions with existing setups on the machine. Please
use your motherboard settings to switch between systems.

I find configuring `grub2` very awkward. I am not sure the configuration
included here is taken into account. If not then the default is and works well
enough.

## References
1. https://wiki.voidlinux.org/Install_LVM_LUKS_on_UEFI_GPT
1. https://wiki.voidlinux.org/Post_Installation#Wireless-only_access
