{ config, lib, pkgs, ... }:

{
  services.openvpn.servers = {
    homeVPN = {
      config = "config /run/agenix/homeVPN ";
      autoStart = false;
      updateResolvConf = true;
    };
  };
}
