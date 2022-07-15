{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.programs.thunar;
in
{
  options.my.programs.thunar = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      xfce.exo
      xfce.thunar
      xfce.tumbler
      xfce.xfconf
    ];
    services.gvfs = {
      enable = true;
      package = lib.mkForce pkgs.gnome3.gvfs;
    };
  };
}
