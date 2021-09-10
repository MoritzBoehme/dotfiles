{
  description = "My awesome system config";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/release-1.2.0-without-deprecated-code";

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    picom = {
      url = "github:jonaburg/picom";
      flake = false;
    };
  };

  outputs = inputs@{ self, utils, home-manager, nixpkgs, ...}:
    utils.lib.mkFlake {
      inherit self inputs;

      # Channel definitions.
      # Channels are automatically generated from nixpkgs inputs
      # e.g the inputs which contain `legacyPackages` attribute are used.
      channelsConfig.allowUnfree = true;


      nix.package = nixpkgs.nixFlakes;
      nix.extraOptions = ''
        experimental-features = nix-command flakes
      '';

      hostDefaults.modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
        ./modules
      ];

      hosts.nixos-laptop.modules = [
        ./hosts/nixos-laptop
      ];
    };
}
