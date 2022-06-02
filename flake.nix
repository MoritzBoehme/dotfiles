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

  outputs = inputs@{ self, nixpkgs, utils, ... }:
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      ################
      ### Overlays ###
      ################

      overlay = import ./overlays { inherit inputs; };
      # overlays = utils.lib.exportOverlays { inherit (self) pkgs inputs; };

      channels.nixpkgs.overlaysBuilder = channels: [
        self.overlay
        inputs.utils.overlay
        inputs.emacs-overlay.overlay
        inputs.nur.overlay
      ];

      ###############
      ### Modules ###
      ###############

      nixosModules = utils.lib.exportModules [ ./modules/default.nix ];
      hostDefaults.modules = [
        ./modules
        inputs.home-manager.nixosModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs self; };
          };
        }
        self.nixosModules.default
        inputs.agenix.nixosModules.age
        inputs.base16.nixosModule
      ];

      hosts.nixos-laptop.modules =
        [ ./hosts/nixos-laptop ./config/nixos-laptop.nix ];

      hosts.nixos-desktop.modules =
        [ ./hosts/nixos-desktop ./config/nixos-desktop.nix ];

      ###############
      ### Outputs ###
      ###############

      outputsBuilder = channels:
        with channels.nixpkgs; {
          devShell = mkShell {
            name = "dotfiles";
            shellHook = ''
              alias "lint"='echo "Running nixpkgs-fmt ..."
                            nixpkgs-fmt --check $(find . -name "*.nix")
                            echo ""
                            echo "Running statix ..."
                            statix check'
              alias "fix"='echo "Running nixpkgs-fmt ..."
                            nixpkgs-fmt $(find . -name "*.nix")
                            echo ""
                            echo "Running statix ..."
                            statix fix'
            '';
            packages = [
              # Linting
              nixpkgs-fmt
              statix
              # Secrets
              pkgs.agenix
              # chachix
              cachix
            ];
          };
        };
    };
}
