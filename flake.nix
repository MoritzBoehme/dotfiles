{
  description = "My awesome system config";

  ##############
  ### Inputs ###
  ##############

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/release-21.05";
    # unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/release-21.05";
    nur.url = "github:nix-community/NUR";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/1.3.0";
    agenix.url = "github:ryantm/agenix";

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    home-manager = { url = "github:nix-community/home-manager"; };
    picom = {
      url = "github:jonaburg/picom";
      flake = false;
    };
    zsh-autosuggestions = {
      url = "github:zsh-users/zsh-autosuggestions";
      flake = false;
    };
    zsh-syntax-highlighting = {
      url = "github:zsh-users/zsh-syntax-highlighting";
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

      hosts.nixos-laptop.modules = [ ./hosts/nixos-laptop ];
      hosts.nixos-desktop.modules = [
        ./hosts/nixos-desktop
        # self.nixosModules.containers
        self.nixosModules.gaming
      ];

      ###############
      ### Outputs ###
      ###############

      outputsBuilder = channels:
        with channels.nixpkgs; {
          devShell = mkShell {
            name = "dotfiles";
            packages =
              [ nixpkgs-fmt agenix.defaultPackage.x86_64-linux cachix ];
          };
        };
    };
}
