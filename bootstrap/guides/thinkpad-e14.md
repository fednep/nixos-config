# Partition layout creation

Commands I used to bootstrap NixOS dev environment onto my old laptop
(ThinkPad E14).

```
export NIXDEV=nvme1n1

# Creating partitions
parted /dev/$NIXDEV mklabel gpt
parted /dev/$NIXDEV mkpart ESP fat32 1MiB 1Gib
parted /dev/$NIXDEV set 1 esp on
parted /dev/$NIXDEV mkpart primary 1GiB 100%

# Formatting partitions
mkfs.vfat /dev/${NIXDEV}p1
cryptsetup luksFormat /dev/${NIXDEV}p2
cryptsetup luksOpen /dev/${NIXDEV}p2 nixos-enc
mkfs.ext4 -L nixos /dev/mapper/nixos-enc

# Mounting and generating configuration file
mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/${NIXDEV}p1 /mnt/boot
nixos-generate-config --root /mnt

```

## Add hardward-configuration.nix to the github repo

I did this section from another computer.

The goal is to copy autogenerated file for laptop's
hardware into this repository:
`/mnt/etc/nixos/hardware-configuration.nix`

```
export NIXADDR=192.168.0.55
scp root@$NIXADDR:/mnt/etc/nixos/hardware-configuration.nix ./systems/thinkpad-e14-hardware.nix

# Create new configuration from template
# Files: system/thinkpad.nix
# Files: system/thinkpad-e14-hardware.nix
# Update file: flake.nix

git add system/thinkpad-e14-hardware.nix
git add system/thinkpad.nix
git commit
git push
```

## Install system from the flake

Clone the whole repository and install the system from it.

```
nix-env -i git
cd /root
git clone https://github.com/fednep/nixos-config
nixos-install --impure --flake /root/nixos-config#thinkpad-e14
```
