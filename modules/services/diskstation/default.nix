{ config, lib, pkgs, ... }:

{
  services.davfs2 = {
    enable = true;
    extraConfig = "trust_server_cert diskstation.pem";
  };
  services.autofs = {
    enable = true;
    autoMaster =
      let
        mapConf = pkgs.writeText "auto" ''
          keepass -fstype=davfs,uid=1000 :https\://davs.home.boehmies.de/home/Drive/
        '';
      in
        ''
          /auto file:${mapConf}
        '';
    debug = true;
  };

  home-manager.users.moritz = {
    services.unison = {
      enable = true;
      pairs = {
        keepass.roots = [
          "/home/moritz/Keepass"
          "/auto/keepass"
        ];
        diskstation.roots = [
          "/home/moritz/Documents"
          "/auto/diskstation"
        ];
      };
    };
  };
}
