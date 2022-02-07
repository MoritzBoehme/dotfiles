{ pkgs }:

pkgs.writeShellApplication {
  name = "randomWallpaper";

  runtimeInputs = with pkgs; [ findutils coreutils ];

  text = ''
    wallpaper="$(find ~/.config/wallpapers/ -type f,l | shuf -n 1)"
    feh --bg-fill "$wallpaper"
  '';
}
