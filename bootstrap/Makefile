# I based this on  mitchellh/nixos-config Makefile and modified it heavily.
# https://github.com/mitchellh/nixos-config
#
#
# Connectivity info for Linux VM
NIXADDR ?= unset
NIXPORT ?= 22
NIXUSER ?= fedir
NIXBLOCKDEVICE ?= sda
SWAPSIZE ?= 8GiB

# SSH options that are used. These aren't meant to be overridden but are
# reused a lot so we just store them up here.
SSH_OPTIONS=-o PubkeyAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no

# Get the path to this Makefile and directory
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# Perform initial NixOS installation on a brand new VM.
# The VM should have NixOS ISO booted from the CD drive
# and the password of the root user set to "root".
vm/init:
	ssh $(SSH_OPTIONS) -p$(NIXPORT) root@$(NIXADDR) " \
		parted /dev/$(NIXBLOCKDEVICE) -- mklabel gpt; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart primary 512MiB -$(SWAPSIZE); \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart primary linux-swap -$(SWAPSIZE) 100\%; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart ESP fat32 1MiB 512MiB; \
		parted /dev/$(NIXBLOCKDEVICE) -- set 3 esp on; \
		mkfs.ext4 -L nixos /dev/$(NIXBLOCKDEVICE)1; \
		mkswap -L swap /dev/$(NIXBLOCKDEVICE)2; \
		mkfs.fat -F 32 -n boot /dev/$(NIXBLOCKDEVICE)3; \
		mount /dev/disk/by-label/nixos /mnt; \
		mkdir -p /mnt/boot; \
		mount /dev/disk/by-label/boot /mnt/boot; \
		mkdir -p /mnt/etc/nixos \
		"
	$(MAKE) vm/init-copy-initial
	$(MAKE) vm/init-do-install

vm/init-copy-initial:
	scp $(SSH_OPTIONS) -P$(NIXPORT) \
		./system/configuration.nix \
		./system/hardware-configuration.nix \
		root@$(NIXADDR):/mnt/etc/nixos

vm/init-do-install:
	ssh $(SSH_OPTIONS) -p$(NIXPORT) root@$(NIXADDR) " \
		nixos-install --no-root-passwd; \
		reboot \
	"

vm/complete:
	$(MAKE) vm/sync
	$(MAKE) vm/apply-system
	$(MAKE) vm/apply-user
	$(MAKE) vm/reboot

vm/reboot:
	ssh $(SSH_OPTIONS) -p$(NIXPORT) $(NIXUSER)@$(NIXADDR) " \
		sudo reboot; \
	"

# copy the Nix configurations into the VM.
vm/sync:
	rsync -av -e 'ssh $(SSH_OPTIONS) -p$(NIXPORT)' \
		--exclude='vendor/' \
		--exclude='iso/' \
		--rsync-path="sudo rsync" \
		$(MAKEFILE_DIR)/ $(NIXUSER)@$(NIXADDR):/nixos-config

# Applies configuration
vm/apply-system:
	ssh $(SSH_OPTIONS) -p$(NIXPORT) $(NIXUSER)@$(NIXADDR) " \
		sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable; \
		sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz home-manager; \
		sudo nix-channel --update; \
		sudo nixos-rebuild switch -I nixos-config=/nixos-config/system/configuration.nix; \
	"
vm/apply-user:
	ssh $(SSH_OPTIONS) -p$(NIXPORT) $(NIXUSER)@$(NIXADDR) " \
		home-manager switch -f /nixos-config/users/fedir/home.nix \
	"

# after bootstrap0, run this to finalize. After this, do everything else
# in the VM unless secrets change.

switch:
	sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake ".#${NIXNAME}"

test:
	sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild test --flake ".#$(NIXNAME)"

# copy our secrets into the VM
vm/secrets:
	# GPG keyring
	rsync -av -e 'ssh $(SSH_OPTIONS)' \
		--exclude='.#*' \
		--exclude='S.*' \
		--exclude='*.conf' \
		$(HOME)/.gnupg/ $(NIXUSER)@$(NIXADDR):~/.gnupg
	# SSH keys
	rsync -av -e 'ssh $(SSH_OPTIONS)' \
		--exclude='environment' \
		$(HOME)/.ssh/ $(NIXUSER)@$(NIXADDR):~/.ssh



# Build an ISO image
iso/nixos.iso:
	cd iso; ./build.sh

