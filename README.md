# Void Linux installation and configuration
We write a series of scripts to install a Void Linux session from another
Linux distribution. We also write the deployment of our personal configuration.

## Dependencies
To run the scripts, you need:
* `sfdisk`: A scriptable version of `fdisk`.
* `cryptsetup`: To configure the encrypted LVM LUKS partition.
* `wget`
* `mkfs.fat`, `mkswap` and `mkfs.ext4`.

## Usage
Just run:

```shell
./void-install.sh /dev/sdx voidvm host
```

Replacing:
* **/dev/sdx** with the device on which Void Linux must be installed.
* **voidvm** with the name of the volume group you want to use. Must not already
be present on the machine you are using to perform the installation.
* **host** hostname to use for the new machine.

## Partioning
We use an encrypted `root`. We do not have the need for encrypted boot
currently. The template we use on the disk is:
* Boot: 512M
* LVM LUKS
  * Swap: 16G
  * Root: The rest of disk space.

## References
1. https://wiki.voidlinux.org/Install_LVM_LUKS_on_UEFI_GPT
