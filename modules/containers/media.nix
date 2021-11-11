{ config, lib, pkgs, ... }:
let
  dockerDir = "/home/moritz/Docker/";
  mediaDir = "/media/media/";
  puid = "1000";
  pgid = "100";
  timeZone = "Europe/Berlin";
in
{
  home-manager.users.moritz = {
    home.packages = with pkgs; [ docker-compose ];
    home.file = {
      "Media/compose.yml".text = ''
        version: '3.9'
        services:
          transmission-openvpn:
            container_name: transmission
            cap_add:
              - NET_ADMIN
            volumes:
              - "${dockerDir}/Transmission:/data/"
            environment:
              - LOCAL_NETWORK=192.168.0.0/24
              - OPENVPN_PROVIDER=NORDVPN
              - OPENVPN_USERNAME=''${OPENVPN_USERNAME}
              - OPENVPN_PASSWORD=''${OPENVPN_PASSWORD}
              - TRANSMISSION_ALT_SPEED_DOWN=70000
              - TRANSMISSION_ALT_SPEED_TIME_ENABLED=true
              - TRANSMISSION_ALT_SPEED_UP=2000
              - TRANSMISSION_MAX_PEERS_GLOBAL=1000
              - TRANSMISSION_PEER_LIMIT_GLOBAL=1000
              - TRANSMISSION_PEER_LIMIT_PER_TORRENT=100
              - TRANSMISSION_RATIO_LIMIT=10
              - TRANSMISSION_RATIO_LIMIT_ENABLED=true
              - TZ=${timeZone}
              - ENABLE_UFW=true
              - UFW_ALLOW_GW_NET=true
              - PUID=${puid}
              - PGID=${pgid}
            logging:
              driver: json-file
              options:
                max-size: 10m
            ports:
              - '9091:9091'
            image: haugene/transmission-openvpn:3.7.1
            restart: unless-stopped
            networks:
              - default

          jackett:
            image: lscr.io/linuxserver/jackett
            container_name: jackett
            environment:
              - PUID=${puid}
              - PGID=${pgid}
              - TZ=${timeZone}
              - AUTO_UPDATE=true #optional
            volumes:
              - "${dockerDir}/Jackett/config:/config"
              - "${dockerDir}/Jackett/blackhole:/downloads"
            ports:
              - 9117:9117
            restart: unless-stopped
            networks:
              - default

          radarr:
            image: lscr.io/linuxserver/radarr
            container_name: radarr
            environment:
              - PUID=${puid}
              - PGID=${pgid}
              - TZ=${timeZone}
            volumes:
              - "${mediaDir}/movies:/movies"
              - "${dockerDir}/Transmission/completed/movies:/downloads"
              - "${dockerDir}/Radarr:/config"
            ports:
              - 7878:7878
            restart: unless-stopped
            networks:
              - default

          sonarr:
            image: lscr.io/linuxserver/sonarr
            container_name: sonarr
            environment:
              - PUID=${puid}
              - PGID=${pgid}
              - TZ=${timeZone}
            volumes:
              - "${mediaDir}/tv:/tv"
              - "${dockerDir}/Transmission/completed/tv:/downloads"
              - "${dockerDir}/Sonarr:/config"
            ports:
              - 8989:8989
            restart: unless-stopped
            networks:
              - default

          bazarr:
            image: lscr.io/linuxserver/bazarr
            container_name: bazarr
            environment:
              - PUID=${puid}
              - PGID=${pgid}
              - TZ=${timeZone}
            volumes:
              - "${mediaDir}/tv:/tv"
              - "${mediaDir}/movies:/movies"
              - "${dockerDir}/Bazarr:/config"
            ports:
              - 6767:6767
            restart: unless-stopped
            networks:
              - default

        networks:
          default:
            driver: bridge
      '';
      "Media/start.sh" = {
        text = ''
          #!/usr/bin/env bash
          sudo docker-compose --env-file /run/secrets/nordvpn --file /home/moritz/Media/compose.yml down
          sudo docker-compose --env-file /run/secrets/nordvpn --file /home/moritz/Media/compose.yml up -d
        '';
        executable = true;
      };
    };
  };
  #   "bazarr" = {
  #     image = "linuxserver/bazarr";
  #     environment = {
  #       "PUID" = "1000";
  #       "PGID" = "100";
  #       "TZ" = "DE";
  #     };
  #     volumes = [
  #       "/media/media/tv:/tv"
  #       "/media/media/movies:/movies"
  #       "/home/moritz/Docker/Bazarr:/config"
  #     ];
  #     ports = [ "6767:6767" ];
  #     extraOptions = [ "--ip=172.17.0.6" ];
  #   };
  # };
}
