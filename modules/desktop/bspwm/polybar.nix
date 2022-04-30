{ config, lib, pkgs, ... }:

let cfg = config.modules.desktop;
in {
  config = lib.mkIf (cfg.name == "bspwm") {
    home-manager.users.moritz = {
      services.polybar = {
        enable = true;
        package = pkgs.polybar.override { pulseSupport = true; };
        script = ''
          for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
            MONITOR=$m polybar --reload bottom &
          done
        '';
        config = with config.scheme.withHashtag; {
          "global/wm" = { margin-top = 5; };
          "bar/bottom" = {
            # position
            monitor = "\${env:MONITOR}";
            bottom = true;
            width = "100%:-20";
            heigth = 25;
            background = base00;
            foreground = base05;
            radius = 10;
            offset-x = 10;
            offset-y = 5;
            padding = 1;

            line-size = 3;
            line-color = base06;

            module-margin = 1;
            separator = "%{F${base03}}◆%{F-}";

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
              "%{F${base0B}}<animation-charging>%{F-} <label-charging>";
            format-discharging =
              "%{F${base08}}<animation-discharging>%{F-} <label-discharging>";
            format-full = "%{F${base08}} %{F-} <label-full>";

            label-charging = "%percentage%% %time% remaining";
            label-discharging = "%percentage%% %time% remaining";
            label-full = "Fully charged";

            animation-charging-0 = " ";
            animation-charging-1 = " ";
            animation-charging-2 = " ";
            animation-charging-3 = " ";
            animation-charging-4 = " ";
            animation-charging-framerate = 500;

            animation-discharging-0 = " ";
            animation-discharging-1 = " ";
            animation-discharging-2 = " ";
            animation-discharging-3 = " ";
            animation-discharging-4 = " ";
            animation-discharging-framerate = 500;
          };
          "module/bspwm" = {
            type = "internal/bspwm";

            label-focused = "";
            label-focused-foreground = base0E;
            label-focused-padding = 1;

            label-occupied = "";
            label-occupied-foreground = base03;
            label-occupied-padding = 1;

            label-urgent = "";
            label-urgent-foreground = base08;
            label-urgent-padding = 1;

            label-empty = "";
            label-empty-foreground = base03;
            label-empty-padding = 1;

            label-separator = " ";
            label-separator-foreground = base0C;
            label-separator-padding = 1;

            pin-workspaces = true;
          };
          "module/cpu" = {
            type = "internal/cpu";
            interval = 2;
            format = "<ramp-load><label>";

            ramp-load-0 = " ";
            ramp-load-0-foreground = base0B;
            ramp-load-1 = " ";
            ramp-load-1-foreground = base0B;
            ramp-load-2 = " ";
            ramp-load-2-foreground = base0A;
            ramp-load-3 = " ";
            ramp-load-3-foreground = base08;

            label = "%percentage:2%%";
          };
          "module/time" = {
            type = "internal/date";
            interval = 1;

            time = "%H:%M";
            time-alt = "%H:%M:%S";

            label = "%time%";
            format-prefix = " ";
            format-prefix-foreground = base0C;
          };
          "module/date" = {
            type = "internal/date";
            interval = 5;

            date = "%A";
            date-alt = "%Y-%m-%d";

            label = "%date%";
            format-prefix = " ";
            format-prefix-foreground = base0A;

          };
          "module/memory" = {
            type = "internal/memory";
            interval = 2;
            format = "<ramp-used><label>";

            ramp-used-0 = " ";
            ramp-used-0-foreground = base0B;
            ramp-used-1 = " ";
            ramp-used-1-foreground = base0B;
            ramp-used-2 = " ";
            ramp-used-2-foreground = base0A;
            ramp-used-3 = " ";
            ramp-used-3-foreground = base08;

            label = "%gb_used%";
          };
          "module/pulseaudio" = {
            type = "internal/pulseaudio";

            format-volume = "<ramp-volume> <label-volume>";
            format-underline = base0A;
            label-volume = "%percentage%%";

            label-muted = "%{F${base08}}婢 %{F-}muted";
            ramp-volume-0 = "奄";
            ramp-volume-0-foreground = base0B;
            ramp-volume-1 = "奄";
            ramp-volume-1-foreground = base0B;
            ramp-volume-2 = "奔";
            ramp-volume-2-foreground = base0B;
            ramp-volume-3 = "墳";
            ramp-volume-3-foreground = base0A;
            ramp-volume-4 = "墳";
            ramp-volume-4-foreground = base08;

            click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
          };
          "module/network" = {
            type = "internal/network";
            interface =
              builtins.head (builtins.attrNames config.networking.interfaces);
            interval = 3;
            format-connected = "<label-connected>";
            label-connected =
              "%{F${base0E}}祝%{F-} %upspeed% %{F${base06}}%{F-} %downspeed%";
          };
        };
      };
    };
  };
}
