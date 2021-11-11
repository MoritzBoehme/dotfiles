{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {

    services.polybar = {
      enable = true;
      package = pkgs.polybar.override { pulseSupport = true; };
      script = ''
        for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
                           MONITOR=$m polybar --reload bottom &
                         done
      '';
      config = ./config.ini;
      extraConfig = builtins.readFile ./modules.ini
        + builtins.readFile ./colors.ini;
    };
  };
}
