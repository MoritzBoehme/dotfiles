{ config, lib, pkgs, ... }:

{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  environment.shellInit = ''
    export GPG_TTY="$(tty)"
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
  '';
  home-manager.users.moritz.home.packages = with pkgs; [
    # cli
    yubikey-manager
    yubikey-personalization
    paperkey
    stable.haskellPackages.hopenpgp-tools
    # graphical
    yubikey-manager-qt
    yubikey-personalization-gui
  ];
}
