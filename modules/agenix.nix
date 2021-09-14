{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = [
    inputs.agenix.defaultPackage.x86_64-linux
  ];
  age.secrets.nordvpn.file = ../secrets/nordvpn.age;
  age.secrets.davfs = {
    file = ../secrets/davfs.age;
    mode = "600";
    path = "/etc/davfs2/secrets";
  };
}
