{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.programs.xmonad;
in
{
  options.my.programs.xmonad = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = lib.mkIf cfg.enable {
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
    home-manager.users.moritz =
      let
        xmonadPackages = haskellPackages: [
          haskellPackages.xmonad-contrib
          haskellPackages.xmonad-extras
          haskellPackages.xmonad
          haskellPackages.xmobar
        ];
      in
      {
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
