{ config, lib, pkgs, ... }:
let cfg = config.modules.desktop;
in {
  imports = [ ./apps ./bspwm ./gtk.nix ./xmonad ./sway ];

  options.modules.desktop = {
    name = lib.mkOption {
      default = "bspwm";
      type = lib.types.enum [ "bspwm" "xmonad" "sway" ];
    };
  };

  config = {
    home-manager.users.moritz = {
      services.unclutter.enable = true;

      xdg = {
        enable = true;
        configFile = {
          "wallpapers/" = {
            source = ./wallpapers;
            recursive = true;
          };
        };
      };
    };
    # Remap capslock to esc and shift + capslock to capslock
    services.xserver.xkbOptions =
      "terminate:ctrl_alt_bksp,caps:escape_shifted_capslock";
  };
}
