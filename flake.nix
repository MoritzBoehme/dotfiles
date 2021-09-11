{
  description = "My awesome system config";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/release-1.2.0-without-deprecated-code";
    nur.url = "github:nix-community/NUR";

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    picom = {
      url = "github:jonaburg/picom";
      flake = false;
    };
    zsh-autosuggestions = {
      url = "github:zsh-users/zsh-autosuggestions";
      flake = false;
    };
  };

  outputs = inputs@{ self, utils, home-manager, nixpkgs, ...}:
    utils.lib.mkFlake {
      inherit self inputs;


      channels.nixpkgs.overlaysBuilder = channels: [
        self.overlay
        inputs.utils.overlay
        inputs.emacs-overlay.overlay
        inputs.nur.overlay
      ];


      overlay = import ./overlays { inherit inputs; };
      overlays = utils.lib.exportOverlays {
        inherit (self) pkgs inputs;
      };


      outputsBuilder = channels: {
        packages = utils.lib.exportPackages self.overlays channels;
        devShell = channels.nixpkgs.mkShell {
          packages = with channels.nixpkgs; [ nixpkgs-fmt rnix-lsp ];
        };
      };

      channelsConfig.allowUnfree = true;

      nixosModules = utils.lib.exportModules [
        ./modules/default.nix
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
      ];

      hosts.nixos-laptop.modules = [
        ./hosts/nixos-laptop
      ];
    };
}
