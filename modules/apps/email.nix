{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = { home.packages = with pkgs; [ thunderbird ]; };
  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [ protonmail-bridge ];
  systemd.user.services.protonmail-bridge = {
    description = "Protonmail Bridge";
    enable = true;
    script =
      "${pkgs.protonmail-bridge}/bin/protonmail-bridge --log-level debug";
    path = [
      pkgs.gnome3.gnome-keyring
    ]; # HACK: https://github.com/ProtonMail/proton-bridge/issues/176
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };
  networking.firewall.allowedTCPPorts = [ 33728 1025 1143 ];
}
