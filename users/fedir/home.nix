{ config, pkgs, ... }:

{
  imports = [
    ./xresources.nix
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    tree
	git
	git-crypt

	gnupg
	pinentry_qt

    fd
	fzf
	htop
	gopls
	watch

    silver-searcher # Ag tool for vim plugin

    neovim
    zsh
  ];

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
  };

  # There is a bug in Nix that .profile is not sourced when opening new shell
  # because of this, home.sessionVariables will not work correctly, until that bug is fixed
  # https://github.com/nix-community/home-manager/issues/1011
  home.file.".xprofile".text = ''
      . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
  '';

  programs.fish = {
    enable = true;

    # Theme settings
    interactiveShellInit = ''
      set -g theme_newline_cursor yes
      set -g fish_prompt_pwd_dir_length 0
      set -g theme_color_scheme zenburn
      set -g theme_newline_prompt '$ '
      '';

    plugins = [
      {
        name="foreign-env";
        src = pkgs.fishPlugins.foreign-env;
      }

      {
        name="theme-bobthefish";
        src = pkgs.fishPlugins.theme-bobthefish;
      }
    ];

  };

  # in this case it will source sessionVariables defined above correctly
  programs.bash = {
    enable = true;
  };

  programs.git = {
	enable = true;
	userName = "Fedir Nepyivoda";
	userEmail = "fednep@gmail.com";

    extraConfig = {
        color = {
          ui = "auto";
        };

        pull = {
          rebase = true;
        };
      };
    };

  programs.go = {
	enable = true;
  };

  programs.gpg = {
	enable = true;
  };

#    services.gpg-agent = {
#  	enable = true;
#  	pinentryFlavor = "qt";
#    };

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
