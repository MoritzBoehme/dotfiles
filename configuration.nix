# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
 
  # BOOT
  boot = {
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  # NETWORKING
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;    
 
    useDHCP = false;
    interfaces.enp0s3.useDHCP = true;
  };

  # LOCALS 
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };
  time.timeZone = "Europe/Berlin";

  # SERVICES
  services = {
    xserver = {
      enable = true;
      layout = "de";
    
      displayManager = {
        defaultSession = "none+bspwm";
      
        autoLogin = {
          enable = true;
          user = "moritz";
        };
        lightdm = {
          enable = true;
        };
      };
    
      windowManager.bspwm.enable = true;
    };
    printing.enable = true;
  };
  # HOMEMANAGER

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # USERS
  users.users.moritz = {
    shell = pkgs.zsh;
    isNormalUser = true;
    home = "/home/moritz";
    extraGroups = [ "wheel" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
  };
 
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ];})
  ];
 
  # PACKAGES
  environment.systemPackages = with pkgs; [
    vim 
    wget
    firefox
    st
    git
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

