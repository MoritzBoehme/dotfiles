{ config, lib, pkgs, ... }:

{
  services.davfs2 = {
    enable = true;
    extraConfig = ''
      buf_size 32
      use_compression 1
      table_size 4096
      [/auto/diskstation]
      trust_server_cert diskstation.pem
      [/auto/media]
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
        media -fstype=davfs,uid=1000 :https\://192.168.0.2\:5006/media
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
        diskstation = {
          roots = [ "/home/moritz/Documents" "/auto/diskstation" ];
          commandOptions = {
            auto = "true";
            batch = "true";
            log = "false";
            repeat = "watch";
            sshcmd = "\${pkgs.openssh}/bin/ssh";
            ui = "text";
            fastcheck = "true";
          };
        };
      };
    };
  };
}
