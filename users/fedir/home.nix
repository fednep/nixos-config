{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.enable = true;

  home.packages = with pkgs; [
	git
	git-crypt
	gnupg
	pinentry_qt

	fzf
	htop
	gopls
	watch

	rofi
  ];

  programs.git = {
	enable = true;
	userName = "Fedir Nepyivoda";
	userEmail = "fednep@gmail.com";
  };

  programs.go = {
	enable = true;
  };

  programs.gpg = {
	enable = true;
  };

  services.gpg-agent = {
	enable = true;
	pinentryFlavor = "qt";
  };

  programs.alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";
    };
  };

  # Make sursor not tiny on HiDPI screens
  xsession.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
  };

  xresources.extraConfig = builtins.readFile ./Xresources;


  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "fedir";
  home.homeDirectory = "/home/fedir";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

}
