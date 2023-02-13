{ config, pkgs, ... }:
{
  imports = [
    ./dev-srv-hardware.nix
    ./roles/dev-x.nix
  ];

  # set fn keys to work on the keyboard in Mac mode
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=0
  '';

  services.xserver.dpi = 210;
  networking.hostName = "dev-srv"; # Define your hostname.

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}

