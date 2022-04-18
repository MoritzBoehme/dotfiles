{ config, lib, pkgs, ... }:

{
  users.users.moritz.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGoAqa2m7hIzZ2LS96Z+RCIlRvhBM/j7h27tMBCwMT+a" # Moritz
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDhtwHDGAZshiQWKkCcPWV9tC83b+bKBgjDcjP/N2CKO" # Laptop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKl8gMhwSf1NsP5gp14xbbyjqQLZzcHLb/XKRMoHdXgI" # Desktop
  ];
}
