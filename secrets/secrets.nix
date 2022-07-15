let
  moritz = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGoAqa2m7hIzZ2LS96Z+RCIlRvhBM/j7h27tMBCwMT+a";
  gpg = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHlemuKagHwz2T5rEwgJNlVUdUdOXyPtCEzD73CrwY2zmpR4AMj7y9u3Rm7HwHUDjLap1ZFwg+53bAsVP6HFZccCXoIfO/8BL0WDGQJrfgb+A+UiRhSqSvyZ77bGJkadbBkadguz3qR3PHcb41DOlhuqVcHxsY8ceHMxAuyb0pLJVJLeytMD+CHS/r7hoj2hckTNAZ+VhCXBtdZfZ7uPUBxLfluYRNNMmdwCglsg3RUS242nJUzy3A84+CXIGeWmNG9Fu45IDkwMthxSW9klyU9R38R9DBDcugkyb6vz+JKSuRVAa47qh/kmtsYekfL3ul9D2JN32P8S+6ZoXx+gXupGJ0ltwJWAFkhLJ+yeXj9kCOv/mIUmCB14jMGsvKiSwV25O/twyjqe2LEkMVgimgrjEYoHu+ZTyp0iFtUvSrFo4tsAhfWPV9yj4F/hUksW7xKIwq5Niyx7he5M/XddudtnAximyiBDGCdJm1Ejl0UaGa6ZQv7y6VZdx0PyZuraT7l9ub8so6JlE4cVgSSU9vE0IS2QqBuHhsIjh8RVksoTR2NQbeDdGaGpGnq2C8y0rDXwE/EJA4LK45khX/GPn73n8F0kBG8dBrWgRDAEODpmebScO7d5mCeM0z3lPcRmh+3e3DPnVVOl+uR7udlc7NauLzl7q913UtxZaF1PlD7Q==";
  users = [ moritz gpg ];

  nixos-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDhtwHDGAZshiQWKkCcPWV9tC83b+bKBgjDcjP/N2CKO";
  nixos-desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKl8gMhwSf1NsP5gp14xbbyjqQLZzcHLb/XKRMoHdXgI";
  hosts = [ nixos-laptop nixos-desktop ];
in
{
  "nordvpn.age".publicKeys = users ++ hosts;
  "spotifyd.age".publicKeys = users ++ hosts;
  "email-desktop.age".publicKeys = users ++ hosts;
  "email-laptop.age".publicKeys = users ++ hosts;
  "home-vpn.age".publicKeys = users ++ hosts;
  "home-vpn-password.age".publicKeys = users ++ hosts;
  "github.age".publicKeys = users ++ hosts;
  "uni-vpn.age".publicKeys = users ++ hosts;
}
