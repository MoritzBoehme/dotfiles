let
  moritz =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGoAqa2m7hIzZ2LS96Z+RCIlRvhBM/j7h27tMBCwMT+a";
  users = [ moritz ];

  nixos-laptop =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDhtwHDGAZshiQWKkCcPWV9tC83b+bKBgjDcjP/N2CKO";
  nixos-desktop =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKl8gMhwSf1NsP5gp14xbbyjqQLZzcHLb/XKRMoHdXgI";
  hosts = [ nixos-laptop nixos-desktop ];
in {
  "nordvpn.age".publicKeys = users ++ hosts;
  "davfs.age".publicKeys = users ++ hosts;
  "smbMoritz.age".publicKeys = users ++ hosts;
  "smbMedia.age".publicKeys = users ++ hosts;
  "spotifyd.age".publicKeys = users ++ hosts;
  "email-desktop.age".publicKeys = users ++ hosts;
  "email-laptop.age".publicKeys = users ++ hosts;
  "home-vpn.age".publicKeys = users ++ hosts;
}
