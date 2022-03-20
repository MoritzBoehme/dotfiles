{ config, lib, pkgs, inputs, ... }:

{
  services.sshd.enable = true;
  age.secrets = {
    nordvpn = {
      file = ../../secrets/nordvpn.age;
      owner = "1000";
    };
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
    homeVPN = {
      file = ../../secrets/home-vpn.age;
      owner = "1000";
    };
    homeVPNPassword = {
      file = ../../secrets/home-vpn-password.age;
      owner = "1000";
    };
  };
}
