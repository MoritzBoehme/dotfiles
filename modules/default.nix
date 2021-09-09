{ lib, pkgs, ... }:

{
  imports = [
    ./bspwm
    ./dunst
    ./emacs
    ./polybar
    ./git.nix
    ./kitty.nix
    ./picom.nix
    ./rofi.nix
    ./zathura.nix
    ./zsh.nix
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
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "21.05";
  };
}
