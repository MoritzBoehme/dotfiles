{ inputs }:

final: prev: {
  picom = prev.picom.overrideAttrs (old: { src = inputs.picom; });
  stable = import inputs.stable {
    inherit (prev) system;
    config.allowUnfree = true;
  };
  nur = import inputs.nur { inherit (prev) system; };
  nixStable = prev.nix_2_4;
}
