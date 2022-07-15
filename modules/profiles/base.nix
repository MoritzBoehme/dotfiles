{ config
, lib
, pkgs
, ...
}:

with lib;
{
  users.users.moritz = {
    isNormalUser = true;
    home = "/home/moritz";
    extraGroups = [ "wheel" ]; # "networkmanager" "video" "dialout"
    initialPassword = "password"; # CHANGE ME PLEASE
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGoAqa2m7hIzZ2LS96Z+RCIlRvhBM/j7h27tMBCwMT+a" # Moritz
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDhtwHDGAZshiQWKkCcPWV9tC83b+bKBgjDcjP/N2CKO" # Laptop
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKl8gMhwSf1NsP5gp14xbbyjqQLZzcHLb/XKRMoHdXgI" # Desktop
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHlemuKagHwz2T5rEwgJNlVUdUdOXyPtCEzD73CrwY2zmpR4AMj7y9u3Rm7HwHUDjLap1ZFwg+53bAsVP6HFZccCXoIfO/8BL0WDGQJrfgb+A+UiRhSqSvyZ77bGJkadbBkadguz3qR3PHcb41DOlhuqVcHxsY8ceHMxAuyb0pLJVJLeytMD+CHS/r7hoj2hckTNAZ+VhCXBtdZfZ7uPUBxLfluYRNNMmdwCglsg3RUS242nJUzy3A84+CXIGeWmNG9Fu45IDkwMthxSW9klyU9R38R9DBDcugkyb6vz+JKSuRVAa47qh/kmtsYekfL3ul9D2JN32P8S+6ZoXx+gXupGJ0ltwJWAFkhLJ+yeXj9kCOv/mIUmCB14jMGsvKiSwV25O/twyjqe2LEkMVgimgrjEYoHu+ZTyp0iFtUvSrFo4tsAhfWPV9yj4F/hUksW7xKIwq5Niyx7he5M/XddudtnAximyiBDGCdJm1Ejl0UaGa6ZQv7y6VZdx0PyZuraT7l9ub8so6JlE4cVgSSU9vE0IS2QqBuHhsIjh8RVksoTR2NQbeDdGaGpGnq2C8y0rDXwE/EJA4LK45khX/GPn73n8F0kBG8dBrWgRDAEODpmebScO7d5mCeM0z3lPcRmh+3e3DPnVVOl+uR7udlc7NauLzl7q913UtxZaF1PlD7Q==" # GPG
    ];
  };

  time.timeZone = "Europe/Berlin";

  my = {
    shell = {
      abbreviations = {
        us = "systemctl --user";
        rs = "doas systemctl";
      };
      aliases = {
        ls = "exa -lh --icons --git";
        cat = "bat";
        grep = "rg";
        rm = "rm -i";
        mv = "mv -i";

        nix-switch = "doas nixos-rebuild switch --flake ~/.dotfiles";
        nix-boot = "doas nixos-rebuild boot --flake ~/.dotfiles";
        nix-lock = "pushd ~/.dotfiles && nix flake update && popd";

        nixpkgs-review = "nixpkgs-review-checks";

        latexwatch = ''find -type f -name "*.tex" | entr -c latexmk -pdf -silent'';
      };
      variables = { EDITOR = "vim"; };
    };
  };

  console.keyMap = "de";

  environment.systemPackages = with pkgs; [
    # archives
    p7zip
    unzip
    zip

    # file management
    ranger
    trash-cli

    # monitoring
    htop
    bottom

    # nix
    comma
    nix-index
    nixpkgs-fmt
    statix

    # other
    arduino
    bat
    cht-sh
    du-dust
    duf
    entr
    exa
    gparted
    hub
    neofetch
    tmux
    ttyper
    up
    viu
    wget
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ];
    })
  ];

  programs = {
    mtr.enable = true;
    command-not-found.enable = true;
  };

  services = {
    sshd.enable = true; # for agenix
    btrfs.autoScrub.enable =
      lib.mkDefault
        (builtins.any (filesystem: filesystem.fsType == "btrfs")
          (builtins.attrValues config.fileSystems));
  };

  home-manager.users.moritz = {
    programs = {
      # Let Home Manager install and manage itself.
      home-manager.enable = true;
      fzf.enable = true;
      starship.enable = true;
    };
    home = {
      username = "moritz";
      homeDirectory = "/home/moritz";
      language = {
        base = "en_US.UTF-8";
        time = "de_DE.UTF-8";
        numeric = "de_DE.UTF-8";
        paper = "de_DE.UTF-8";
      };
      stateVersion = "21.05";
    };
    xdg.userDirs.enable = true;
  };
}
