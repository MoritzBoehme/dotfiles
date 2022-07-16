{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.programs.kitty;
in
{
  options.my.programs.kitty = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = mkIf cfg.enable {
    my.shell.aliases.ssh = "kitty +kitten ssh";
    home-manager.users.moritz = {
      programs.kitty = {
        enable = true;
        settings = {
          scrollback_lines = 10000;
          enable_audio_bell = false;
          cursor_shape = "underline";
          window_padding_width = 3;
          confirm_os_window_close = 0;
        };
        keybindings = {
          "ctrl+plus" = "change_font_size all +2.0";
          "ctrl+minus" = "change_font_size all -2.0";
        };
        font = {
          name = "FiraCode Nerd Font";
          size = 10;
        };
      };
      xdg.configFile."kitty/ssh.conf" = {
        text = ''
          env TERM=xterm-color
        '';
      };
    };
  };
}
