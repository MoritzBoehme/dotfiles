{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.programs.ledger;
in
{
  options.my.programs.ledger = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = mkIf cfg.enable {
    my.shell.aliases = {
      bal = "ledger bal";
      balcash = "ledger bal -R -X € --current --flat ^assets:bank ^liabilities";
      balnet = "ledger bal -R -X € --current --depth 2 ^assets ^liabilities";
      bud = ''ledger --budget --unbudgeted bal ^expenses -p "this month"'';
      budr = ''ledger --budget reg -p "this month" ^expenses'';
      reg = "ledger reg -R -V --tail 15";
    };
    home-manager.users.moritz = {
      home.packages = with pkgs; [ ledger ];
      xdg.configFile = {
        "fish/completions/ledger.fish" = {
          text = builtins.readFile ./ledger.fish;
        };
        "ledger/ledgerrc".text = ''
          --strict
          --explicit
          --payee note
          --file ~/Notes/ledger/main.ledger
        '';
      };
    };
  };
}
