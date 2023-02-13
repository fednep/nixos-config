{ config, pkgs, ... }:

{
  imports = [
    ./xresources.nix
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
	pinentry_qt
  ];

  # There is a bug in Nix that .profile is not sourced when opening new shell
  # because of this, home.sessionVariables will not work correctly, until that bug is fixed
  # https://github.com/nix-community/home-manager/issues/1011
  home.file.".xprofile".text = ''
      . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
  '';

  programs.alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";
    };
  };

  # Make sursor not tiny on HiDPI screens
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
  };
}

