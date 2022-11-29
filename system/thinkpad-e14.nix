{ pkgs, ... }:
{
  imports = [
    ./thinkpad-e14-hardware.nix
    ./templates/dev.nix
  ];

  services.xserver.dpi = 110;
  networking.hostName = "nixos-thinkpad"; # Define your hostname.

  # Allow installing "unfree" packages like vs code
  nixpkgs.config.allowUnfree = true;

  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}

