{ config, lib, pkgs, ... }:

let cfg = config.modules.desktop;
in {
  config = lib.mkIf (cfg.name == "xmonad") {
    services = {
      xserver = {
        enable = true;
        layout = "de";

        displayManager = {
          defaultSession = "none+xmonad";
          autoLogin = {
            enable = true;
            user = "moritz";
          };
          lightdm.enable = true;
        };
        windowManager.xmonad.enable = true;
      };
    };
    console.keyMap = "de";
    home-manager.users.moritz = let
      xmonadPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
        haskellPackages.xmobar
      ];
    in {
      xsession.windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./xmonad.hs;
        # extraPackages = xmonadPackages;
      };
      programs.xmobar.enable = true;
    };
  };
}
