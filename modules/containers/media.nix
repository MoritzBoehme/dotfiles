{ config, lib, pkgs, ... }:

{
  containers.radarr = {
    config = { config, pkgs, ... }: { services.radarr.enable = true; };
    bindMounts = {
      "/dowloads" = {
        hostPath = "/var/lib/Transmission/Downloads/completed/";
        isReadOnly = true;
      };
    };
  };
  containers.sonarr = {
    config = { config, pkgs, ... }: { services.sonarr.enable = true; };
    bindMounts = {
      "/dowloads" = {
        hostPath = "/var/lib/Transmission/Downloads/completed/";
        isReadOnly = true;
      };
    };
  };
  containers.jackett = {
    config = { config, pkgs, ... }: { services.jackett.enable = true; };
  };
  containers.transmission = {
    config = { config, pkgs, ... }: {
      # services.openvpn = { servers = { nordvpn = { }; }; };
      networking.firewall = {
        enable = true;
        # extraStopCommands = ''
        #   sudo iptables -N ALLOWVPN
        #   sudo iptables -N BLOCKALL

        #   # allow access for the interfaces loopback, tun, and tap
        #   sudo iptables -A OUTPUT -o tun+ -j ACCEPT;
        #   sudo iptables -A OUTPUT -o tap+ -j ACCEPT;
        #   sudo iptables -A OUTPUT -o lo+ -j ACCEPT;

        #   # route outgoing data via our created chains
        #   sudo iptables -A OUTPUT -j ALLOWVPN;
        #   sudo iptables -A OUTPUT -j BLOCKALL;

        #   # block all disallowed connections
        #   sudo iptables -A BLOCKALL -j DROP
        # '';
      };
    };
    bindMounts = {
      "/var/lib/transmission" = { hostPath = "/home/moritz/Transmission/"; };
    };
  };

}
