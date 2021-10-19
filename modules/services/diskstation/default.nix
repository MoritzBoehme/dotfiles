{ config, lib, pkgs, ... }:

{
  services.davfs2 = {
    enable = true;
    extraConfig = ''
      [/auto/keepass]
      trust_server_cert home-boehmies-de.pem
    '';
  };
  services.autofs = {
    enable = true;
    autoMaster = let
      mapConf = pkgs.writeText "auto" ''
        keepass -fstype=davfs,uid=1000 :https\://davs.home.boehmies.de/home/Drive/
      '';
    in ''
      /auto file:${mapConf}
    '';
  };
  environment.etc."davfs2/certs/home-boehmies-de.pem" = {
    text = builtins.readFile ./home-boehmies-de.pem;
  };

  fileSystems."/media/media" = {
    device = "//192.168.0.2/media";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts =
        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in [
      "${automount_opts},credentials=/run/secrets/smbMedia,uid=1000,gid=100"
    ];
  };

  fileSystems."/media/diskstation" = {
    device = "//192.168.0.2/home/Drive";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts =
        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in [
      "${automount_opts},credentials=/run/secrets/smbMoritz,uid=1000,gid=100"
    ];
  };

  # home-manager.users.moritz = {
  #   services.unison = {
  #     enable = true;
  #     pairs = {
  #       keepass = {
  #         roots = [ "/home/moritz/Keepass" "/auto/keepass" ];
  #         commandOptions = {
  #           auto = "true";
  #           batch = "true";
  #           log = "false";
  #           repeat = "watch";
  #           sshcmd = "\${pkgs.openssh}/bin/ssh";
  #           ui = "text";
  #           ignore = "Name {lost+found}";
  #         };
  #       };
  #       diskstation = {
  #         roots = [ "/home/moritz/Documents" "/media/diskstation" ];
  #         commandOptions = {
  #           auto = "true";
  #           batch = "true";
  #           log = "false";
  #           repeat = "watch";
  #           sshcmd = "\${pkgs.openssh}/bin/ssh";
  #           ui = "text";
  #           fastcheck = "true";
  #           # debug = "verbose";
  #           perms = "0o1666";
  #           ignore = "Name {.direnv}";
  #         };
  #       };
  #     };
  #   };
  # };
}
