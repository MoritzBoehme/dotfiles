{ lib, pkgs, ... }:

{
  imports = [
    ./cachix.nix
    ./cli
    ./desktop
    ./editors
    ./gaming.nix
    ./security.nix
    ./services
    ./theming.nix
  ];

  # USERS
  users.users.moritz = {
    isNormalUser = true;
    home = "/home/moritz";
    extraGroups =
      [ "wheel" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
    initialPassword = "password"; # CHANGE ME PLEASE
  };

  fonts.fonts = with pkgs;
    [
      (nerdfonts.override {
        fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ];
      })
    ];

  time.timeZone = "Europe/Berlin";

  # PACKAGES
  environment.systemPackages = with pkgs; [ vim wget firefox git ];
  programs.mtr.enable = true;

  home-manager.users.moritz = {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # paths it should manage.
    home.username = "moritz";
    home.homeDirectory = "/home/moritz";

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    home.language = {
      base = "en_US.UTF-8";
      time = "de_DE.UTF-8";
      numeric = "de_DE.UTF-8";
      paper = "de_DE.UTF-8";
    };

    home.stateVersion = "21.05";
  };
}
