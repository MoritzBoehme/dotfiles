{ inputs }:

final: prev: {
  picom = prev.picom.overrideAttrs (old: {
    src = inputs.picom;
  });
  unstable = import inputs.unstable {
    system = prev.system;
    config.allowUnfree = true;
  };
  nur = import inputs.nur {
    system = prev.system;
  };
}
