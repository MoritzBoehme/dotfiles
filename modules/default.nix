{ lib, pkgs, ... }:

{
  imports = [
    ./bspwm
    ./dunst
    ./emacs
    ./polybar
    ./rofi
    ./agenix.nix
    ./diskstation.nix
    ./git.nix
    ./kitty.nix
    ./picom.nix
    ./zathura.nix
    ./zsh.nix
    ./nix.nix
  ];

  # USERS
  users.users.moritz = {
    shell = pkgs.zsh;
    isNormalUser = true;
    home = "/home/moritz";
    extraGroups = [ "wheel" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono"];})
  ];

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

    services = {
      kdeconnect.enable = true;
    };

    home.packages = with pkgs; [
      neofetch
      keepassxc
      spotify
      spicetify-cli
    ];

    home.stateVersion = "21.05";
  };
}
