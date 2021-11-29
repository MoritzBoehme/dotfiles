{ config, lib, pkgs, ... }:

{
  fileSystems."/media/media" = {
    device = "//192.168.0.2/media";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts =
        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in [
      "${automount_opts},credentials=/run/agenix/smbMedia,uid=1000,gid=100"
    ];
  };
}
