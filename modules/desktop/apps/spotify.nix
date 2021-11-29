{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    home.packages = with pkgs; [ spotify-tui ];
    services.spotifyd = {
      enable = true;
      package = pkgs.spotifyd.override { withMpris = true; };
      settings = {
        global = {
          # A command that gets executed and can be used to
          # retrieve your username.
          username_cmd = "${pkgs.coreutils}/bin/head -n 1 /run/agenix/spotifyd";

          # A command that gets executed and can be used to
          # retrieve your password.
          password_cmd = "${pkgs.coreutils}/bin/tail -n 1 /run/agenix/spotifyd";

          # The name that gets displayed under the connect tab on
          # official clients. Spaces are not allowed!
          device_name = "spotifyd";

          # The audio bitrate. 96, 160 or 320 kbit/s
          bitrate = 320;

          # Volume on startup between 0 and 100
          initial_volume = "71";
        };
      };
    };
    xdg.configFile."spotify-tui/config.yml".text = ''
      # Dracula theme
      theme:
        active: "139,233,253"                # current playing song in list
        banner: "80,250,123"                 # the "spotify-tui" banner on launch
        error_border: "241,250,140"          # error dialog border
        error_text: "248,248,242"            # error message text (e.g. "Spotify API
                                             # reported error 404")
        hint: "241,250,140"                  # hint text in errors
        hovered: "255,184,108"               # hovered pane border
        inactive: "248,248,242"              # borders of inactive panes
        playbar_background: "68,71,90"       # background of progress bar
        playbar_progress: "248,248,242"      # filled-in part of the progress bar
        playbar_progress_text: "248,248,242" # song length and time played/left
                                             # indicator in the progress bar
        playbar_text: "248,248,242"          # artist name in player pane
        selected: "80,250,123"               # a) selected pane border, b) hovered item
                                             # in list, & c) track title in player
        text: "248,248,242"                  # text in panes
        header: "248,248,242"                # header text in panes (e.g. 'Title',
                                             # 'Artist', etc.)
      behavior:
        volume_increment: 5
    '';
  };
}
