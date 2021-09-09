{ lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  # paths it should manage.
  home.username = "moritz";
  home.homeDirectory = "/home/moritz";

  programs = {
    git = {
      enable = true;
      userName = "MoritzBoehme";
      userEmail = "mr.x@moritzboeh.me";
    };

    zathura = {
      enable = true;
      options = {
        recolor = true;
        completion-bg = "#282a36";
        completion-fg = "#ff79c6";
        default-bg = "#44475a";
        default-fg = "#bd93f9";
        inputbar-bg = "#282a36";
        inputbar-fg = "#8be9fd";
        statusbar-bg = "#282a36";
        statusbar-fg = "#bd93f9";
        font = "Jetbrains Mono 9";
        recolor-lightcolor = "#282a36";
        recolor-darkcolor = "#f8f8f2";
      };
    };

    zsh = {
      enable = true;

      shellGlobalAliases = {
        ls = "exa -lh";
        cat = "bat";
      };

      plugins = [
                  {
                    name = "zsh-autosuggestions";
                    src = pkgs.fetchFromGitHub {
                      owner = "zsh-users";
                      repo = "zsh-autosuggestions";
                      rev = "v0.4.0";
                      sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
                    };
                  }
                  {
                    name = "zsh-syntax-highlighting";
                    src = pkgs.fetchFromGitHub {
                      owner = "zsh-users";
                      repo = "zsh-syntax-highlighting";
                      rev = "0e1bb14452e3fc66dcc81531212e1061e02c1a61";
                      sha256 = "09ncmyqlk9a3h470z0wgbkrznb5zyc9dj96011wm89rdxc1irxk2";
                    };
                  }
      ];
    };

    kitty = {
      enable = true;
      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        cursor_shape = "underline";
      };
      extraConfig = builtins.readFile ~/.dotfiles/config/kitty/dracula.conf;
      font = {
        name = "FiraCode Nerd Font";
        size = 10;
      };
    };

    exa.enable = true;
    bat.enable = true;

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    rofi = {
      enable = true;
      theme = ~/.dotfiles/config/rofi/dracula_old.rasi;
    };

    emacs.enable = true;
  };
  
  xdg = {
    enable = true;
    configFile = {
      "sxhkd/sxhkdrc" = {
        source = ~/.dotfiles/config/sxhkd/sxhkdrc;
        onChange = "pkill -USR1 -x sxhkd";
      };
      "bspwm/bspwmrc" = {
        source = /home/moritz/.dotfiles/config/bspwm/bspwmrc;
        onChange = "bspc wm -r";
      };
      "doom" = {
        source = ~/.dotfiles/config/doom;
        recursive = true;
        # onChange = builtins.readFile ~/.dotfiles/config/doom/reload.sh;
        onChange = ''
                   #!/bin/sh
                   DOOM="$HOME/.emacs.d"
                   if [ ! -d "$DOOM" ]; then
                     git clone https://github.com/hlissner/doom-emacs.git "$DOOM"
                     "$DOOM/bin/doom" -y install
                   fi

                   "$DOOM/bin/doom" sync

                   '';
      };
      "dunst/dunstrc" = {
        source = ~/.dotfiles/config/dunst/dunstrc;
      };
    };
  };

  services = {
    polybar = {
      enable = true;
      script = ''for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
                   MONITOR=$m polybar --reload bottom &
                 done
               '';
      config = ~/.dotfiles/config/polybar/config.ini;
      extraConfig = builtins.readFile ~/.dotfiles/config/polybar/modules.ini +
                    builtins.readFile ~/.dotfiles/config/polybar/colors.ini;
    };

    picom = {
      enable = true;
      inactiveOpacity = "0.95";
      opacityRule = [
        "100:fullscreen"
        "80 :class_g   = 'Polybar'"
      ];
      blur = true;
      inactiveDim = "0.1";
    };

    emacs = {
      enable = true;
      package = pkgs.emacsUnstable;
    };

    dunst.enable = true;

    kdeconnect.enable = true;
  };


  home.packages = with pkgs; [
    neofetch
    feh
    keepassxc
  ];

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
