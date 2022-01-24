{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 3600;
    };
  };
  services.pcscd.enable = true;
}
