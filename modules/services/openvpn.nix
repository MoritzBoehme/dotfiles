{ config, lib, pkgs, ... }:

{
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
}
