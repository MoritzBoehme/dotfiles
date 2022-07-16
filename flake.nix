{
  description = "My awesome system config";

  ##############
  ### Inputs ###
  ##############

  inputs = {
    master.url = "github:nixos/nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-22.05";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    statix = {
      url = "github:nerdypepper/statix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-review-checks = {
      url = "github:SuperSandro2000/nixpkgs-review-checks";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    comma = {
      url = "github:nix-community/comma";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Fish specific
    dracula-fish = {
      url = "github:dracula/fish";
      flake = false;
    };

    # Zsh specific
    forgit-git = {
      url = "github:wfxr/forgit";
      flake = false;
    };

    # Laptop Touchpad
    asus-touchpad-numpad-driver = {
      url = "github:MoritzBoehme/asus-touchpad-numpad-driver/german-layout";
      flake = false;
    };

    arkenfox-userjs = {
      url = "github:arkenfox/user.js";
      flake = false;
    };

    # Theming
    base16 = {
      url = "github:SenchoPens/base16.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , utils
    , ...
    }:
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      ################
      ### Overlays ###
      ################

      overlays.default = import ./overlays { inherit inputs; };
      channels.nixpkgs.overlaysBuilder = channels: [
        self.overlays.default
        inputs.utils.overlay
        inputs.emacs-overlay.overlay
        inputs.nur.overlay
      ];

      ###############
      ### Modules ###
      ###############

      nixosModules = utils.lib.exportModules [
        ./modules/profiles/base.nix
        ./modules/profiles/gaming.nix
        ./modules/profiles/desktop.nix
      ];
      hostDefaults.modules = [
        ./modules/default.nix
        self.nixosModules.base
        inputs.home-manager.nixosModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs self; };
          };
        }
        inputs.agenix.nixosModules.age
        inputs.base16.nixosModule
      ];

      hosts.nixos-laptop.modules = [
        ./hosts/nixos-laptop
        self.nixosModules.desktop
      ];
      hosts.nixos-desktop.modules = [
        ./hosts/nixos-desktop
        self.nixosModules.desktop
        self.nixosModules.gaming
      ];

      ###############
      ### Outputs ###
      ###############

      outputsBuilder = channels:
        with channels.nixpkgs; {
          devShells.default = mkShell {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            name = "dotfiles";
            packages = [
              # Secrets
              pkgs.agenix
              # cachix
              cachix
            ];
          };
          checks.pre-commit-check = inputs.pre-commit-hooks.lib."${system}".run {
            src = ./.;
            hooks = {
              nixpkgs-fmt.enable = true;
              statix.enable = true;
              shellcheck.enable = true;
            };
          };
        };
    };
}
