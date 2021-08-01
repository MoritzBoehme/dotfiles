{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "moritz";
  home.homeDirectory = "/home/moritz";

  programs.git = {
    enable = true;
    userName = "MoritzBoehme";
    userEmail = "mr.x@moritzboeh.me";
  };
  
  # Zathura
  programs.zathura = {
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

  # Zsh
  programs.zsh = {
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

  # Kitty
  programs.kitty = { 
    enable = true;
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      cursor_shape = "underline";
    }; 
    #extraConfig = builtins.readFile ./kitty/dracula.conf;
    font = {
      name = "FiraCode Nerd Font";
      size = 10;
    };
  };

  programs.exa.enable = true;
  programs.bat.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  
  services.polybar = {
    enable = true;
    script = ''
             # Terminate already running bar instances
             killall -q polybar
    
             # Wait until the processes have been shut down
             while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
             while ! pgrep -x bspwm >/dev/null; do sleep 1; done
    
             # Launch Polybar
             for m in $(polybar --list-monitors | cut -d":" -f1); do
               MONITOR=$m polybar --reload bottom &
             done
             '';
    config = {
      "bar/bottom" = {
         monitor = "\${env:MONITOR}";
         bottom = true;
         fixed-center = true;
         width = "100%";
         height = 25;
         background = "\${color.background-alt}";
         foreground = "\${color.foreground}";
         line-size = 3;
         border-size = 0;
         padding-left = 1;
         padding-right = 1;
         module-margin-left = 3;
         module-margin-right = 3;
         font-0 = "NotoSans Nerd Font:size=11;0";
         modules-left = "cpu memory wlan eth battery";
         modules-center = "bspwm";
         modules-right = "pulseaudio date powermenu";
         tray-position = "right";
         tray-background = "\${color.background-alt}";
         tray-padding = 2;
         wm-restack = "bspwm";
         cursor-click = "pointer";
      };
    };
  };
  
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
