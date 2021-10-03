{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    "transmission" = {
      image = "haugene/transmission-openvpn";
      environmentFiles = [ /run/secrets/nordvpn ];
      environment = {
        "LOCAL_NETWORK" = "192.168.0.0/24";
        "OPENVPN_PROVIDER" = "NORDVPN";
        "TRANSMISSION_ALT_SPEED_DOWN" = "20000";
        "TRANSMISSION_ALT_SPEED_TIME_ENABLED" = "true";
        "TRANSMISSION_ALT_SPEED_UP" = "2000";
        "TRANSMISSION_MAX_PEERS_GLOBAL" = "1000";
        "TRANSMISSION_PEER_LIMIT_GLOBAL" = "1000";
        "TRANSMISSION_PEER_LIMIT_PER_TORRENT" = "100";
        "TRANSMISSION_RATIO_LIMIT" = "10";
        "TRANSMISSION_RATIO_LIMIT_ENABLED" = "true";
        "TZ" = "DE";
        "ENABLE_UFW" = "true";
        "PUID" = "1000";
        "PGID" = "100";
      };
      ports = [ "9091:9091" ];
      volumes = [ "/home/moritz/Docker/Transmission:/data/" ];
      extraOptions = [ "--cap-add=NET_ADMIN" ];
    };

    "jackett" = {
      image = "linuxserver/jackett";
      environment = {
        "PUID" = "1000";
        "PGID" = "100";
        "TZ" = "DE";
      };
      volumes = [
        "/home/moritz/Docker/jackett/config:/config"
        "/home/moritz/Docker/jackett/blackhole:/downloads"
      ];
      ports = [ "9117:9117" ];
    };

    "radarr" = {
      image = "linuxserver/radarr";
      environment = {
        "PUID" = "1000";
        "PGID" = "100";
        "TZ" = "DE";
      };
      volumes = [
        "/auto/media/movies:/movies"
        "/home/moritz/Docker/transmission/completed/movies:/downloads"
        "/home/moritz/Docker/radarr"
      ];
      ports = [ "7878:7878" ];
    };
    "sonarr" = {
      image = "linuxserver/sonarr";
      environment = {
        "PUID" = "1000";
        "PGID" = "100";
        "TZ" = "DE";
      };
      volumes = [
        "/auto/media/tv:/tv"
        "/home/moritz/Docker/transmission/completed/movies:/downloads"
        "/home/moritz/Docker/sonarr"
      ];
      ports = [ "8989:8989" ];
    };
  };
}
