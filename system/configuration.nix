# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "0";

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Kiev";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.ens33.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  services.xserver =  {

	enable = true;
#	dpi = 220;
	dpi = 110;

    autoRepeatDelay = 200;
    autoRepeatInterval = 30;

	desktopManager = {
		xterm.enable = false;
		wallpaper.mode = "scale";
	};

	displayManager = {
		defaultSession = "none+i3";
		lightdm.enable = true;
	};

	windowManager.i3 = {
		enable = true;
		extraPackages = with pkgs; [
			dmenu
			i3status
			i3lock
			i3blocks
		];
	};
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  hardware.video.hidpi.enable = true;
  security.sudo.wheelNeedsPassword = false;

  virtualisation.vmware.guest.enable = true;
  virtualisation.docker.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.mutableUsers = false;

  # Define a user account.
  users.users.fedir = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$6$HbmKJ9X/Mtl7xTl8$ADp3i4prozbYsW7zik7BBkqu0ZZJPewVm9VoryI10Nww3ifwAXm9QIO6jjttfoXXyIrg/wCbzzmCoGtDTUBgt0";
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDD5YU7HVVdocDLyWMPmcjlDx0z6NGuTJkkkJKxJzLX15ruU5wwdU0+gly4KJacJ2Mj8OEreMq7u1mDOcV8f4IyEGYpy6g2Qfurg0iZ97O8xvwcCVbOXrz4GLAAtbPkXzpApm/O002oWO+qLxz4LvaVrL9M2w+w2Sxpj0JfggKS5Uxp5RfS5bnTjtANdLpm10ev1EFtVM6H0chTkVH/YpZEqKMAOgNk+v5LFhe9xQPw1s+9fUvnDmU9GKq7FApYModTnh5sgt4Agi1tGPZM/wpUuH/G70En1GizPjpaiGcjuGF/+RNq7OHbrt/ed5WnCezo0OZ7b1zYyBFlYBiSkRot fedir-on-fedir" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gnumake
    killall
    rxvt_unicode
    xclip
    gtkmm3

    vim
    wget
    traceroute
    home-manager
  ];

  fonts.fonts = with pkgs; [
    go-font
    powerline-fonts
    source-code-pro
    fira-code
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = true;
  services.openssh.permitRootLogin = "no";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = "experimental-features = nix-command flakes";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

