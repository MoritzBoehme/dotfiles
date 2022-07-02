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
          "bar/bottom" = {
            # position
            monitor = "\${env:MONITOR}";
            bottom = true;
            width = "100%";
            heigth = 20;

            background = base00;
            foreground = base05;

            border-size = 5;
            border-color = base00;

            separator = " ";

            font-0 = "FiraCode Nerd Font:size=9;0";
            font-1 = "FiraCode Nerd Font:size=9;1";
            font-2 = "FiraCode Nerd Font:size=9;2";

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

            format-charging = "<animation-charging> <label-charging>";
            format-discharging = "<animation-discharging> <label-discharging>";
            format-full = " <label-full>";

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
            format-foreground = base00;
            format-background = base0B;
            format-padding = 1;
            format-font = 3;

            ramp-load-0 = " ";
            ramp-load-1 = " ";
            ramp-load-2 = " ";
            ramp-load-3 = " ";

            label = "%percentage:2%%";
          };
          "module/time" = {
            type = "internal/date";
            interval = 1;

            time = "%H:%M";
            time-alt = "%H:%M:%S";

            label = "%time%";
            format-prefix = " ";
            format-prefix-font = 2;
            format-foreground = base00;
            format-background = base0C;
            format-padding = 1;
            label-font = 3;
          };
          "module/date" = {
            type = "internal/date";
            interval = 5;

            format = "<label>";
            format-prefix = " ";
            format-prefix-font = 2;
            format-foreground = base00;
            format-background = base0A;
            format-padding = 1;
            format-font = 3;

            date = "%A";
            date-alt = "%Y-%m-%d";

            label = "%date%";
            label-font = 3;

          };
          "module/memory" = {
            type = "internal/memory";
            interval = 2;

            format = "<label>";
            format-prefix = " ";
            format-foreground = base00;
            format-background = base0C;
            format-padding = 1;
            format-font = 2;

            label = "%gb_used%";
            label-font = 3;
          };
          "module/pulseaudio" = {
            type = "internal/pulseaudio";

            format-volume = "<ramp-volume> <label-volume>";
            label-volume = "%percentage%%";

            format-volume-foreground = base00;
            format-volume-background = base04;
            format-volume-padding = 1;
            format-volume-font = 2;

            label-muted = "%{F${base08}}婢 %{F${base00}}muted";
            format-muted-foreground = base00;
            format-muted-background = base04;
            format-muted-padding = 1;
            format-muted-font = 2;
            ramp-volume-0 = "奄";
            ramp-volume-1 = "奄";
            ramp-volume-2 = "奔";
            ramp-volume-3 = "墳";
            ramp-volume-4 = "墳";

            click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
          };
          "module/network" = {
            type = "internal/network";
            interface =
              builtins.head (builtins.attrNames config.networking.interfaces);
            interval = 3;
            format-connected = "<label-connected>";
            label-connected = "%{T2}祝%{T3} %upspeed% %{T2}%{T3} %downspeed%";

            format-connected-foreground = base00;
            format-connected-background = base0E;
            format-connected-padding = 1;
            format-connected-font = 3;
          };
        };
      };
    };
  };
}
