{ lib, pkgs, ... }:

{
  imports = [
    ./apps
    ./cli
    ./desktop
    ./services
  ];

  # USERS
  users.users.moritz = {
    shell = pkgs.zsh;
    isNormalUser = true;
    home = "/home/moritz";
    extraGroups = [ "wheel" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
  ];

  time.timeZone = "Europe/Berlin";

  # PACKAGES
  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
  ];

  home-manager.users.moritz = {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # paths it should manage.
    home.username = "moritz";
    home.homeDirectory = "/home/moritz";

    home.stateVersion = "21.05";
  };
}
