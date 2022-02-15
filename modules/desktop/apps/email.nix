{ config, lib, pkgs, ... }:
let
  name = "Moritz Böhme";
  email = "mail@moritzboeh.me";
  mailDirectory = "/home/moritz/.mail";
in {
  environment.systemPackages = with pkgs; [ protonmail-bridge ];
  systemd.user.services.protonmail-bridge = {
    description = "Protonmail Bridge";
    enable = true;
    script =
      "${pkgs.protonmail-bridge}/bin/protonmail-bridge --log-level debug";
    path = [
      pkgs.gnome3.gnome-keyring
    ]; # HACK: https://github.com/ProtonMail/proton-bridge/issues/176
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };
  home-manager.users.moritz = {
    home = { packages = with pkgs; [ thunderbird ]; };
    programs = {
      msmtp.enable = true;
      mbsync.enable = true;
    };

    services = {
      mbsync = {
        enable = true;
        frequency = "*:0/15";
        preExec = "${pkgs.isync}/bin/mbsync -Ha";
        postExec = "${pkgs.mu}/bin/mu index -m ${mailDirectory}";
      };
    };

    accounts.email = {
      maildirBasePath = mailDirectory;
      accounts = {
        default = {
          address = email;
          userName = email;
          flavor = "plain";
          primary = true;
          passwordCommand = "${pkgs.coreutils}/bin/cat /run/agenix/email";
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            patterns = [ "*" ];
          };
          realName = name;
          msmtp.enable = true;
          mu.enable = true;
          imap = {
            host = "127.0.0.1";
            port = 1143;
            tls = {
              enable = true;
              useStartTls = true;
              certificatesFile =
                "/home/moritz/.config/protonmail/bridge/cert.pem";
            };
          };
          smtp = {
            host = "127.0.0.1";
            port = 1025;
            tls = {
              enable = true;
              useStartTls = true;
              certificatesFile =
                "/home/moritz/.config/protonmail/bridge/cert.pem";
            };
          };
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 33728 1025 1143 ];
}
