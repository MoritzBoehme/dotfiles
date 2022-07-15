{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.yubikey;
in
{
  options.my.yubikey = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = {
    services.udev.packages = [ pkgs.yubikey-personalization ];
    environment.systemPackages = with pkgs; [
      # cli
      yubikey-manager
      yubikey-personalization
      paperkey
      # graphical
      yubikey-manager-qt
      yubikey-personalization-gui
    ];
  };
}
