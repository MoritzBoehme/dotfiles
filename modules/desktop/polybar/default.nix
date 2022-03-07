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
          padding = 1;

          line-size = 3;
          line-color = colors.pink;

          module-margin = 1;
          separator = "%{F${colors.comment}}◆%{F-}";

          font-0 = "FiraCode Nerd Font:size=10;0";

          modules-left = "cpu memory network battery";
          modules-center = "bspwm";
          modules-right = "pulseaudio date time";

          tray-position = "right";
          tray-padding = 2;

          wm-restack = "bspwm";

          cursor-click = "pointer";
          cursor-scroll = "ns-resize";
        };
        "module/battery" = {
          type = "internal/battery";
          battery = "BATT";
          adapter = "ACAD";
          time-format = "%H:%M";

          format-charging =
            "%{${colors.green}}<animation-charging>%{F-}  <label-charging>";
          format-discharging =
            "%{${colors.red}}<animation-discharging>%{F-} <label-discharging>";
          format-full = "%{${colors.green}}%{F-} <label-full>";

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
          format = "<ramp-load><label>";

          ramp-load-0 = " ";
          ramp-load-0-foreground = colors.green;
          ramp-load-1 = " ";
          ramp-load-1-foreground = colors.orange;
          ramp-load-2 = " ";
          ramp-load-2-foreground = colors.red;

          label = "%percentage:2%%";
        };
        "module/time" = {
          type = "internal/date";
          interval = 1;

          time = "%H:%M";
          time-alt = "%H:%M:%S";

          label = "%time%";
          format-prefix = " ";
          format-prefix-foreground = colors.cyan;
        };
        "module/date" = {
          type = "internal/date";
          interval = 5;

          date = "%A";
          date-alt = "%Y-%m-%d";

          label = "%date%";
          format-prefix = " ";
          format-prefix-foreground = colors.orange;

        };
        "module/memory" = {
          type = "internal/memory";
          interval = 2;
          format = "<ramp-used><label>";

          ramp-used-0 = " ";
          ramp-used-0-foreground = colors.green;
          ramp-used-1 = " ";
          ramp-used-1-foreground = colors.orange;
          ramp-used-2 = " ";
          ramp-used-2-foreground = colors.red;
          ramp-used-3 = " ";

          label = "%gb_used%";
        };
        "module/pulseaudio" = {
          type = "internal/pulseaudio";

          format-volume = "<ramp-volume> <label-volume>";
          format-underline = colors.orange;
          label-volume = "%percentage%%";

          label-muted = "婢 muted";
          label-muted-foreground = colors.red;
          ramp-volume-0 = "奄";
          ramp-volume-0-foreground = colors.green;
          ramp-volume-1 = "奄";
          ramp-volume-1-foreground = colors.green;
          ramp-volume-2 = "奔";
          ramp-volume-2-foreground = colors.green;
          ramp-volume-3 = "墳";
          ramp-volume-3-foreground = colors.orange;
          ramp-volume-4 = "墳";
          ramp-volume-4-foreground = colors.red;

          click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        "module/network" = {
          type = "internal/network";
          interface =
            builtins.head (builtins.attrNames config.networking.interfaces);
          interval = 3;
          format-connected = "<label-connected>";
          label-connected =
            "%{F${colors.purple}}祝%{F-} %upspeed% %{F${colors.pink}}%{F-} %downspeed%";
        };
      };
    };
  };
}
