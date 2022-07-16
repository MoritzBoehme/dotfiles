{ config
, lib
, pkgs
, inputs
, ...
}:

with lib;
let
  cfg = config.my.programs.firefox;
  arkenfox = builtins.readFile "${inputs.arkenfox-userjs}/user.js";
in
{
  options.my.programs.firefox = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
    overrides = mkOption {
      default = { };
      type = with types; attrsOf (oneOf [ str bool int ]);
      apply = overrides: lib.concatStrings (
        lib.mapAttrsToList
          (
            name: value: ''
              user_pref("${name}", ${builtins.toJSON value});
            ''
          )
          overrides
      );
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.moritz.programs.firefox = {
      enable = true;
      profiles."default".extraConfig = ''
        // Arkenfox user.js
        ${arkenfox}

        // Overrides
        ${cfg.overrides}
      '';
    };
  };
}
