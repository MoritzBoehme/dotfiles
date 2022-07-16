{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.virtualisation.libvirtd;
in
{
  options.my.virtualisation.libvirtd = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      package = pkgs.stable.libvirt;
    };
    home-manager.users.moritz.home.packages = with pkgs; [ virt-manager ];
    users.users.moritz.extraGroups = [ "libvirtd" ];
  };
}
