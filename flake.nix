{
  description = "My awesome system config";

  ##############
  ### Inputs ###
  ##############

  inputs = {
    master.url = "github:nixos/nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nur.url = "github:nix-community/NUR";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    agenix.url = "github:ryantm/agenix";

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    home-manager.url = "github:nix-community/home-manager";

    statix.url = "github:nerdypepper/statix";

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
  };

  outputs = inputs@{ self, agenix, home-manager, nixpkgs, utils, ... }:
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      ################
      ### Overlays ###
      ################

      overlay = import ./overlays { inherit inputs; };
      overlays = utils.lib.exportOverlays { inherit (self) pkgs inputs; };

      channels.nixpkgs.overlaysBuilder = channels: [
        self.overlay
        inputs.utils.overlay
        inputs.emacs-overlay.overlay
        inputs.nur.overlay
      ];

      ###############
      ### Modules ###
      ###############

      nixosModules = utils.lib.exportModules [
        ./modules/default.nix
        ./modules/containers
        ./modules/gaming
      ];

      hostDefaults.modules = [
        home-manager.nixosModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs self; };
          };
        }
        self.nixosModules.default
        agenix.nixosModules.age
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
              agenix.defaultPackage.x86_64-linux
              # chachix
              cachix
            ];
          };
        };
    };
}
