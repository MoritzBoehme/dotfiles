{ config, lib, pkgs, inputs, ... }:

{
  services.sshd.enable = true;
  age.secrets = {
    nordvpn.file = ../../secrets/nordvpn.age;
    davfs = {
      file = ../../secrets/davfs.age;
      mode = "600";
      path = "/etc/davfs2/secrets";
    };
    smbMoritz.file = ../../secrets/smbMoritz.age;
    smbMedia.file = ../../secrets/smbMedia.age;
    spotifyd = {
      file = ../../secrets/spotifyd.age;
      owner = "1000";
    };
    spotify-tui = {
      file = ../../secrets/spotify-tui.age;
      owner = "1000";
      mode = "777";
      path = "/home/moritz/.config/spotify-tui/client.yml";
    };
  };
}
