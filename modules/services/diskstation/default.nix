{ config, lib, pkgs, ... }:

{
  services.davfs2 = {
    enable = true;
    extraConfig = ''
      [/auto/diskstation]
      trust_server_cert diskstation.pem
      [/auto/keepass]
      trust_server_cert home-boehmies-de.pem
    '';
  };
  services.autofs = {
    enable = true;
    autoMaster = let
      mapConf = pkgs.writeText "auto" ''
        keepass -fstype=davfs,uid=1000 :https\://davs.home.boehmies.de/home/Drive/
        diskstation -fstype=davfs,uid=1000 :https\://192.168.0.2\:5006/home/Drive/
      '';
    in ''
      /auto file:${mapConf}
    '';
    debug = true;
  };
  environment.etc."davfs2/certs/diskstation.pem" = {
    text = builtins.readFile ./diskstation.pem;
  };
  environment.etc."davfs2/certs/home-boehmies-de.pem" = {
    text = builtins.readFile ./home-boehmies-de.pem;
  };

  home-manager.users.moritz = {
    services.unison = {
      enable = true;
      pairs = {
        keepass.roots = [ "/home/moritz/Keepass" "/auto/keepass" ];
        diskstation.roots = [ "/home/moritz/Documents" "/auto/diskstation" ];
      };
    };
  };
}
