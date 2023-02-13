{ pkgs, ... }:
{
  imports = [
    ./kvm-vm-hardware.nix
    ./roles/dev-cli.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only

  networking.hostName = "kvm-vm"; # Define your hostname.

  # Allow installing "unfree" packages like vs code
  nixpkgs.config.allowUnfree = true;
}

