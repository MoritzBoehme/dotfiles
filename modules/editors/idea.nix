{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.editors;
in {
  options.modules.editors = {
    idea = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };
  config = mkIf cfg.idea {
    home-manager.users.moritz = {
      home.packages = with pkgs; [ jdk jetbrains.idea-ultimate ];
    };
  };
}
