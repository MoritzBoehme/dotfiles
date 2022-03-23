{ config, lib, pkgs, ... }:

with lib; {
  imports = [ ./emacs.nix ./idea.nix ./vim.nix ./code.nix ];

  options.modules.editors = {
    emacs = mkOption {
      default = true;
      type = types.bool;
      example = false;
    };
    idea = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
    vim = mkOption {
      default = true;
      type = types.bool;
      example = false;
    };
    code = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };
}
