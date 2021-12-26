{ pkgs }:

pkgs.writeShellApplication {
  name = "cheat";

  runtimeInputs = with pkgs; [ curl bat ];

  text = ''curl -s "cheat.sh/$1" | bat'';
}
