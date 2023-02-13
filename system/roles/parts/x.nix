{ pkgs, lib, ... }:
{

  services.xserver =  {

	enable = true;
	dpi = lib.mkDefault 110;

    autoRepeatDelay = 200;
    autoRepeatInterval = 30;

	desktopManager = {
		xterm.enable = false;
		wallpaper.mode = "scale";
	};

	displayManager = {
		defaultSession = "none+i3";
		lightdm.enable = true;
        sessionCommands = ''
          ${pkgs.xorg.xset}/bin/xset r rate 200 40
        '';
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

  fonts.fonts = with pkgs; [
    go-font
    powerline-fonts
    source-code-pro
    fira-code
  ];

  services.xserver = {
    layout = "us,ua";
    xkbOptions = "grp:lctrl_lshift_toggle";
  };

  environment.systemPackages = with pkgs; [
    rxvt-unicode-unwrapped

    xclip
    gtkmm3
    alacritty
	rofi

    firefox
    chromium
  ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  hardware.video.hidpi.enable = true;
}
