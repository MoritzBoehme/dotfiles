{ inputs }:

final: prev: {
  python-dev = import ./python.nix final prev;
  fish = final.master.fish;
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
