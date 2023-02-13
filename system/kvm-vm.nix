{ pkgs, ... }:
{
  imports = [
    ./kvm-vm-hardware.nix
    ./roles/dev-cli.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only

  services.openssh.passwordAuthentication = false;

  networking.hostName = "kvm-vm"; # Define your hostname.
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Allow installing "unfree" packages like vs code
  nixpkgs.config.allowUnfree = true;
}

