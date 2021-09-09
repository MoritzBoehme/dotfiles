{ config, lib, pkgs, ... }:

let
  base = {
    programs.emacs.enable = true;
    services.emacs.enable = true;

    xdg = {
      enable = true;
      configFile = {
        "doom" = {
          source = ./doom;
          recursive = true;
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
      };
    };
  };
in
{
  home-manager.users.moritz = {...}: (base);
}
