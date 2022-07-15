{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.programs.zathura;
in
{
  options.my.programs.zathura = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.moritz.programs.zathura = {
      enable = true;
      options = {
        recolor = true;
        adjust-open = "width";
        font = "Jetbrains Mono 9";
        selection-clipboard = "clipboard";
      };
    };
  };
}
