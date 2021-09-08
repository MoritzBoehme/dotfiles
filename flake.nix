{
  description = "My awesome system config";
  
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/release-21.05;
    unstable.url = github:nixos/nixpkgs/nixos-unstable;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus/release-1.2.0-without-deprecated-code;
    
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, utils, home-manager, ...}: {
    utils.lib.mkFlake = {
      inherit self inputs;

      # Channel definitions.
      # Channels are automatically generated from nixpkgs inputs
      # e.g the inputs which contain `legacyPackages` attribute are used.
      channelsConfig.allowUnfree = true;

      hostDefaults.modules = [
        home-manager.nixos.Modules.home-manager
        ./modules
      ];

      hosts.nixos-laptop.modules = [
        ./hosts/nixos-laptop
      ];
    };
  };
}
