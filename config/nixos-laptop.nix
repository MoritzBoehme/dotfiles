{ config, lib, pkgs, ... }:

{
  modules.desktop.apps.email = {
    enable = true;
    passwordFile = ../secrets/email-desktop.age;
  };
}
