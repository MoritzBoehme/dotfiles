{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = [
    inputs.agenix.defaultPackage.x86_64-linux
  ];
  age.secrets.nordvpn.file = ../secrets/nordvpn.age;
}
