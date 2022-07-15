{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.services.openvpn;
in
{
  options.my.services.openvpn = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = lib.mkIf cfg.enable {
    age.secrets = {
      homeVPN = {
        file = ../../secrets/home-vpn.age;
        owner = "1000";
      };
      homeVPNPassword = {
        file = ../../secrets/home-vpn-password.age;
        owner = "1000";
      };
    };
    services.openvpn.servers = {
      homeVPN = {
        config = "config /run/agenix/homeVPN ";
        autoStart = false;
        updateResolvConf = true;
      };
    };
    systemd.services.openvpn-homeVPN-password = {
      description = "Enter homeVPN password";
      script = "cat /run/agenix/homeVPNPassword | systemd-tty-ask-password-agent";
      wantedBy = [ "openvpn-homeVPN.service" ];
      after = [ "openvpn-homeVPN.service" ];
    };
  };
}
