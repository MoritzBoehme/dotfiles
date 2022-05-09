{ inputs }:

final: prev: {
  python-dev = import ./python.nix final prev;
  nixpkgs-review = inputs.nixpkgs-review-checks.defaultPackage."${prev.system}";
  agenix = inputs.agenix.defaultPackage."${prev.system}";
  comma = inputs.comma.packages."${prev.system}".comma;
  master = import inputs.master {
    inherit (prev) system;
    config.allowUnfree = true;
  };
  stable = import inputs.stable {
    inherit (prev) system;
    config.allowUnfree = true;
  };
  nur = import inputs.nur { inherit (prev) system; };
}
