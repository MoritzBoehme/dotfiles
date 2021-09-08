{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;

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

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
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
        source = ~/.dotfiles/config/bspwm/bspwmrc;
        onChange = "bspc wm -r";
      };
      "doom" = {
        source = ~/.dotfiles/config/doom;
        recursive = true;
        onChange = builtins.readFile ~/.dotfiles/config/doom/reload.sh;
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

  nixpkgs.overlays = [
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
      }))
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
