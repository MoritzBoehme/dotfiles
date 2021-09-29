let
  moritz =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGoAqa2m7hIzZ2LS96Z+RCIlRvhBM/j7h27tMBCwMT+a";
  users = [ moritz ];

  nixos-laptop =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDhtwHDGAZshiQWKkCcPWV9tC83b+bKBgjDcjP/N2CKO";
  nixos-desktop =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEQyvmbmn1dF2CK+vAHHetyEjb0pMIxT6wlVtmdsTnrj";
  hosts = [ nixos-laptop nixos-desktop ];
in {
  "nordvpn.age".publicKeys = users ++ hosts;
  "davfs.age".publicKeys = users ++ hosts;
}
