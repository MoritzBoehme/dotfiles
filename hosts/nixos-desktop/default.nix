# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # BOOT
  boot = {
    supportedFilesystems = [ "btrfs" "ntfs" ];
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };

  # NETWORKING
  networking = {
    hostName = "nixos-desktop";
    defaultGateway = "192.168.0.1";
    nameservers = [ "192.168.0.4" ];
    useDHCP = false;
    interfaces.enp42s0.useDHCP = true;
    networkmanager = {
      enable = true;
      dns = lib.mkIf (config.services.resolved.enable) "systemd-resolved";
    };
  };

  services.resolved.enable = lib.mkDefault false;

  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xrandrHeads = [
    { output = "HDMI-1"; }
    {
      output = "HDMI-0";
      primary = true;
    }
  ];

  # Powersaving
  services.tlp.enable = true;
  powerManagement.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

