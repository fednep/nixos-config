{ config, pkgs, ... }:
{
  home.username = "fedir";
  home.homeDirectory = "/home/fedir";

  home.packages = with pkgs; [
    tree
	git
	git-crypt

	gnupg

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


}

