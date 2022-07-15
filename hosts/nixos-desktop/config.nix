{ config, lib, pkgs, ... }:

{
  modules = {
    gaming = true;

    editors = {
      idea = true;
      code = true;
    };

    desktop.apps.email = {
      enable = true;
      passwordFile = ../secrets/email-desktop.age;
    };
  };
}
