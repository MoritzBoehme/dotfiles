{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.cli.shell;
  exportedVariables = let
    exportVariables =
      lib.mapAttrsToList (n: v: ''set -x ${n} "${v}"'') cfg.variables;
  in lib.concatStringsSep "\n" exportVariables;
in {
  config = lib.mkIf (cfg.name == "fish") {
    # set as default shell
    users.users.moritz.shell = pkgs.fish;
    # needed for nix completions
    programs.fish.enable = true;
    home-manager.users.moritz = {
      programs = {
        fish = {
          enable = true;
          shellAbbrs = cfg.abbreviations;

          shellAliases = cfg.aliases;

          shellInit = ''
            fzf_configure_bindings --git_log=\cg

            # Vi Mode
            fish_vi_key_bindings

            # Emulates vim's cursor shape behavior
            # Set the normal and visual mode cursors to a block
            set fish_cursor_default block
            # Set the insert mode cursor to a line
            set fish_cursor_insert line
            # Set the replace mode cursor to an underscore
            set fish_cursor_replace_one underscore
            # The following variable can be used to configure cursor shape in
            # visual mode, but due to fish_cursor_default, is redundant here
            set fish_cursor_visual block

            # Variables
            ${exportedVariables}
          '';
          functions = {
            gi = ''
              set url https://www.gitignore.io/api
              if test (count $argv) -ne 1
                set list (curl -sL $url/list | string split ",")
                set choice (string split " " $list | fzf -m --preview "curl -sL $url/{}" | string join ",")
              else
                set choice $argv[1]
              end
              curl -sL $url/$choice > .gitignore
            '';
            fish_greeting = "";
            cheat = "cht.sh $argv | bat -p";
          };
          plugins = [{
            name = "dracula";
            src = inputs.dracula-fish;
          }];
        };
        fzf.enableFishIntegration = true;
        starship.enableFishIntegration = true;
      };
      home.packages = with pkgs.fishPlugins; [ fzf-fish pisces ];
    };
  };
}
