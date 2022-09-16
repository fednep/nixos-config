{ config, pkgs, ... }:
{
  imports = [
    ./intel-vm-hardware.nix
    ./templates/dev.nix
  ];

  services.xserver.dpi = 110;
  networking.hostName = "nixos"; # Define your hostname.

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}

