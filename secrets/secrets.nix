let
  nixos-laptop =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDhtwHDGAZshiQWKkCcPWV9tC83b+bKBgjDcjP/N2CKO";
  nixos-desktop =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKl8gMhwSf1NsP5gp14xbbyjqQLZzcHLb/XKRMoHdXgI";
  hosts = [ nixos-laptop nixos-desktop ];
in {
  "nordvpn.age".publicKeys = hosts;
  "spotifyd.age".publicKeys = hosts;
  "email-desktop.age".publicKeys = hosts;
  "email-laptop.age".publicKeys = hosts;
  "home-vpn.age".publicKeys = hosts;
  "home-vpn-password.age".publicKeys = hosts;
  "github.age".publicKeys = hosts;
}
