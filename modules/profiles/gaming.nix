{ config
, lib
, pkgs
, ...
}: {
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    lutris
    legendary-gl
    heroic
  ];
}
