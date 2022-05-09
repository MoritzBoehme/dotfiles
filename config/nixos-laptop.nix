{ config, lib, pkgs, ... }:

{
  modules = {
    editors.code = true;
    desktop.apps.email = {
      enable = true;
      passwordFile = ../secrets/email-desktop.age;
    };
  };
}
