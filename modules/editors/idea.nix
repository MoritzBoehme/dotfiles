{ config, lib, pkgs, ... }:

let cfg = config.modules.editors;
in {
  config = lib.mkIf cfg.idea {
    home-manager.users.moritz = {
      home.packages = with pkgs; [ jdk jetbrains.idea-ultimate ];
    };
  };
}
