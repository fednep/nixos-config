# Creating partitions

```
export NIXDEV=vda

# Creating partitions
parted /dev/$NIXDEV mklabel msdos
parted /dev/$NIXDEV mkpart primary 1MB 100%
parted /dev/$NIXDEV set 1 boot on

# Formatting
mkfs.ext4 -L nixos /dev/${NIXDEV}1
```
