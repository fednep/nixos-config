{ pkgs, ... }:
{
  imports = [
    ./thinkpad-e14-hardware.nix
    ./templates/dev.nix
  ];

  networking.hostName = "nixos-thinkpad"; # Define your hostname.

  services.xserver.dpi = 125;
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
      Xft.dpi: 125
      URxvt*font: xft:DejaVu Sans Mono for Powerline:size=12
    EOF
  '';

  services.xserver = {
    layout = "us,ua";
    xkbOptions = "grp:lctrl_lshift_toggle";
  };

  services.postgresql = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    eksctl
    kubectl
    libreoffice
  ];

  services.illum.enable = true; # Enable backlit control

  # Set location provider for redshift
  location.provider = "manual";
  location.latitude = 50.45466;
  location.longitude = 30.5238;

  services.redshift.enable = true;
  services.redshift.temperature.day = 5500;
  services.redshift.temperature.night = 5500;


  # this will enable libinput instead of synaptics
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.naturalScrolling = true;
  services.xserver.libinput.touchpad.middleEmulation = true;
  services.xserver.libinput.touchpad.tapping = true;

  # Enables wireless support via wpa_supplicant.
  networking.wireless.enable = true;
  networking.firewall.enable = true;

  # Allow installing "unfree" packages like vs code
  nixpkgs.config.allowUnfree = true;
}

