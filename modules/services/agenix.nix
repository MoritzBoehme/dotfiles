{ config, lib, pkgs, inputs, ... }:

{
  services.sshd.enable = true;
  age.secrets = {
    nordvpn = {
      file = ../../secrets/nordvpn.age;
      owner = "1000";
    };
  };
}
