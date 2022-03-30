{ config, lib, pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    package = pkgs.stable.libvirt;
  };
  home-manager.users.moritz.home.packages = with pkgs; [ virt-manager ];
  users.users.moritz.extraGroups = [ "libvirtd" ];
}
