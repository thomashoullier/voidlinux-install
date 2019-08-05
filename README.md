# Void Linux installation and configuration
We write a series of scripts to install a Void Linux session from another
Linux distribution. We also write the deployment of our personal configuration.

## Dependencies
To run the scripts, you need:
* `sfdisk`: A scriptable version of `fdisk`.
* `cryptsetup`: To configure the encrypted LVM LUKS partition.

## Installation
We use an encrypted `root`. We do not have the need for encrypted boot
currently. The template we use on the disk is:
* Boot: 512M
* LVM LUKS
  * Swap: 16G
  * Root: The rest of disk space.



## References
1. https://wiki.voidlinux.org/Install_LVM_LUKS_on_UEFI_GPT
