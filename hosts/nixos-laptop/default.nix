# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # BOOT
  boot = {
    supportedFilesystems = [ "btrfs" ];
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };

  # SERVICES
  services = {
    xserver.libinput.enable = true;
    xserver.libinput.touchpad.disableWhileTyping = true;
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  # NETWORKING
  networking = {
    hostName = "nixos-laptop";
    networkmanager.enable = true;

    useDHCP = false;
    interfaces.wlp1s0.useDHCP = true;
    # interfaces.enp4s0f4u2.useDHCP = true;
  };

  time.timeZone = "Europe/Berlin";

  # Powersaving
  services.tlp.enable = true;
  powerManagement.enable = true;

  # Suspend to disk instead of ram
  services.logind.lidSwitch = "hibernate";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

