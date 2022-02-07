{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    services.polybar = {
      enable = true;
      package = pkgs.polybar.override { pulseSupport = true; };
      script = ''
        for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
                           MONITOR=$m polybar --reload bottom &
                         done
      '';
      config = let
        colors = {
          background = "#282a36";
          current-line = "#44475a";
          foreground = "#f8f8f2";
          comment = "#6272a4";

          cyan = "#8be9fd";
          green = "#50fa7b";
          orange = "#ffb86c";
          pink = "#ff79c6";
          purple = "#bd93f9";
          red = "#ff5555";
          yellow = "#f1fa8c";
        };
      in {
        "global/wm" = { margin-top = 5; };
        "bar/bottom" = {
          # position
          monitor = "\${env:MONITOR}";
          bottom = true;
          width = "100%:-20";
          heigth = 25;
          background = colors.background;
          foreground = colors.foreground;
          radius = 10;
          offset-x = 10;
          offset-y = 5;

          line-size = 3;
          line-color = colors.pink;

          font-0 = "FiraCode Nerd Font:size=10;0";

          modules-left = "cpu memory wlan eth battery";
          modules-center = "bspwm";
          modules-right = "pulseaudio date";

          wm-restack = "bspwm";

          cursor-click = "pointer";
          cursor-scroll = "ns-resize";
        };
        "module/battery" = {
          type = "internal/battery";
          battery = "BATT";
          adapter = "ACAD";
          time-format = "%H:%M";

          format-charging = "<animation-charging>  <label-charging>";
          format-charging-underline = colors.green;
          format-charging-padding = 1;

          format-discharging = "<animation-discharging>  <label-discharging>";
          format-discharging-underline = colors.red;
          format-discharging-padding = 1;

          format-full = "<label-full>";
          format-full-underline = colors.green;
          format-full-padding = 1;

          label-charging = "%percentage%% %time% remaining";
          label-discharging = "%percentage%% %time% remaining";
          label-full = "Fully charged";

          animation-charging-0 = "";
          animation-charging-1 = "";
          animation-charging-2 = "";
          animation-charging-3 = "";
          animation-charging-4 = "";
          animation-charging-framerate = 500;

          animation-discharging-0 = "";
          animation-discharging-1 = "";
          animation-discharging-2 = "";
          animation-discharging-3 = "";
          animation-discharging-4 = "";
          animation-discharging-framerate = 500;
        };
        "module/bspwm" = {
          type = "internal/bspwm";

          label-focused = "";
          label-focused-foreground = colors.purple;
          label-focused-padding = 1;

          label-occupied = "";
          label-occupied-foreground = colors.comment;
          label-occupied-padding = 1;

          label-urgent = "";
          label-urgent-foreground = colors.red;
          label-urgent-padding = 1;

          label-empty = "";
          label-empty-foreground = colors.comment;
          label-empty-padding = 1;

          label-separator = " ";
          label-separator-foreground = colors.cyan;
          label-separator-padding = 1;

          pin-workspaces = true;
        };
        "module/cpu" = {
          type = "internal/cpu";
          interval = 2;
          format-prefix = " ";
          format-prefix-foreground = colors.red;
          format-underline = colors.red;
          format-padding = 2;
          label = "%percentage:2%%";
        };
        "module/date" = {
          type = "internal/date";
          interval = 5;

          date = "%A";
          date-alt = "%Y-%m-%d";

          time = "%H:%M";
          time-alt = "%H:%M:%S";

          format-underline = colors.purple;
          format-padding = 2;

          label = "%date% %time%";

          click-middle = "${pkgs.kitty}/bin/kitty cal -m3";
        };
        "module/memory" = {
          type = "internal/memory";
          interval = 2;
          format-prefix = " ";
          format-prefix-foreground = colors.green;
          format-underline = colors.green;
          format-padding = 2;

          label = "%percentage_used%%";
        };
        "module/pulseaudio" = {
          type = "internal/pulseaudio";

          format-volume = "<ramp-volume> <label-volume>";
          format-padding = 2;
          format-underline = colors.orange;
          label-volume = "%percentage%%";
          label-volume-foreground = colors.foreground;

          label-muted = "婢 muted";
          label-muted-foreground = colors.red;
          ramp-volume-0 = "奄";
          ramp-volume-1 = "奔";
          ramp-volume-2 = "墳";

          click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        "module/eth" = {
          type = "internal/network";
          interface = "enp42s0";
          interval = 3;
          format-connected-underline = colors.purple;
          format-connected = "<label-connected>";
          label-connected = "祝 %upspeed%  %downspeed%";
          format-connected-padding = 2;
        };
        "module/wlan" = {
          type = "internal/network";
          interface = "wlp1s0";
          interval = 3;
          format-connected-underline = colors.purple;
          format-connected = "<label-connected>";
          label-connected = "祝 %upspeed%  %downspeed%";
          format-connected-padding = 2;
        };
      };
    };
  };
}
