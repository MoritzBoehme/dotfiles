{ config, lib, pkgs, ... }:

let
  base = {
    services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
                  pulseSupport = true;
                };
      script = ''for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
                   MONITOR=$m polybar --reload bottom &
                 done
               '';
      config = ./config.ini;
      extraConfig = builtins.readFile ./modules.ini +
                    builtins.readFile ./colors.ini;
    };
  };
in
{
  home-manager.users.moritz = {...}: (base);
}
