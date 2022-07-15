{ config
, lib
, pkgs
, inputs
, ...
}:

with lib;
let
  cfg = config.my.theming;
  schemes = {
    dracula = {
      slug = "Dracula";
      scheme = "Dracula";
      author = "Moritz Boehme based on Dracula Theme";
      base00 = "282a36"; # Background
      base01 = "69ff94"; # Green 2
      base02 = "ffffa5"; # Yellow 2
      base03 = "6272a4"; # Black 2
      base04 = "d6acff"; # Blue 2
      base05 = "f8f8f2"; # Foreground
      base06 = "ff92df"; # Magenta 2
      base07 = "44475a"; # White 2
      base08 = "ff5555"; # Red 1
      base09 = "ff6e6e"; # Red 2
      base0A = "f1fa8c"; # Yellow 1
      base0B = "50fa7b"; # Green 1
      base0C = "8be9fd"; # Cyan 1
      base0D = "bd93f9"; # Blue 1
      base0E = "ff79c6"; # Magenta 1
      base0F = "a4ffff"; # Cyan 2
    };
    catppuccin = {
      slug = "Catpuccin";
      scheme = "Catpuccin";
      author = "Moritz Boehme based on Catppuccin Theme";
      base00 = "1e1e2e"; # Background
      base01 = "abe9b3"; # Green 2
      base02 = "fae380"; # Yellow 2
      base03 = "988ba2"; # Black 2
      base04 = "96cdf8"; # Blue 2
      base05 = "d9e0ee"; # Foreground
      base06 = "ddb6f2"; # Magenta 2
      base07 = "d9e0ee"; # White 2
      base08 = "f28fad"; # Red 1
      base09 = "f28fad"; # Red 2
      base0A = "fae3b0"; # Yellow 1
      base0B = "abe9b3"; # Green 1
      base0C = "89dceb"; # Cyan 1
      base0D = "96cdfb"; # Blue 1
      base0E = "f5c2e7"; # Magenta 1
      base0F = "89dceb"; # Cyan 2
    };
    nord = {
      slug = "Nord";
      scheme = "Nord";
      author = "arcticicestudio";
      base00 = "2E3440";
      base01 = "ECEFF4";
      base02 = "B48EAD";
      base03 = "4C566A";
      base04 = "D8DEE9";
      base05 = "E5E9F0";
      base06 = "434C5E";
      base07 = "8FBCBB";
      base08 = "BF616A";
      base09 = "3B4252";
      base0A = "EBCB8B";
      base0B = "A3BE8C";
      base0C = "88C0D0";
      base0D = "5E81AC";
      base0E = "D08770";
      base0F = "81A1C1";
    };
    onedark = {
      slug = "onedark";
      scheme = "OneDark";
      author = "Lalit Magant (http://github.com/tilal6991)";
      base00 = "282c34";
      base01 = "353b45";
      base02 = "3e4451";
      base03 = "545862";
      base04 = "565c64";
      base05 = "abb2bf";
      base06 = "b6bdca";
      base07 = "c8ccd4";
      base08 = "e06c75";
      base09 = "d19a66";
      base0A = "e5c07b";
      base0B = "98c379";
      base0C = "56b6c2";
      base0D = "61afef";
      base0E = "c678dd";
      base0F = "be5046";
    };
  };
in
{
  options.my.theming = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
    scheme = mkOption {
      default = "dracula";
      type = types.enum (builtins.attrNames schemes);
      apply = name: schemes."${name}";
      example = "nord";
    };
  };
  config = mkIf cfg.enable {
    inherit (cfg) scheme;
    home-manager.users.moritz = {
      programs = {
        kitty.extraConfig =
          mkIf config.my.programs.kitty.enable
            (builtins.readFile (config.scheme {
              template = ''
                # Base16 {{scheme-name}} - kitty color config
                # Scheme by {{scheme-author}}
                background #{{base00-hex}}
                foreground #{{base05-hex}}
                selection_background #{{base05-hex}}
                selection_foreground #{{base00-hex}}
                url_color #{{base04-hex}}
                cursor #{{base03-hex}}
                active_border_color #{{base03-hex}}
                inactive_border_color #{{base01-hex}}
                active_tab_background #{{base00-hex}}
                active_tab_foreground #{{base05-hex}}
                inactive_tab_background #{{base01-hex}}
                inactive_tab_foreground #{{base04-hex}}
                tab_bar_background #{{base01-hex}}

                # normal
                color0 #{{base00-hex}}
                color1 #{{base08-hex}}
                color2 #{{base0B-hex}}
                color3 #{{base0A-hex}}
                color4 #{{base0D-hex}}
                color5 #{{base0E-hex}}
                color6 #{{base0C-hex}}
                color7 #{{base05-hex}}

                # bright
                color8 #{{base03-hex}}
                color9 #{{base09-hex}}
                color10 #{{base01-hex}}
                color11 #{{base02-hex}}
                color12 #{{base04-hex}}
                color13 #{{base06-hex}}
                color14 #{{base0F-hex}}
                color15 #{{base07-hex}}
              '';
            }));
        zathura.extraConfig = builtins.readFile (config.scheme {
          template = ''
            # Base16 {{scheme-name}}
            # Author: {{scheme-author}}

            set completion-bg               "#{{base00-hex}}"
            set completion-fg               "#{{base05-hex}}"
            set completion-group-bg         "#{{base00-hex}}"
            set completion-group-fg         "#{{base03-hex}}"
            set completion-highlight-bg     "#{{base07-hex}}"
            set completion-highlight-fg     "#{{base06-hex}}"

            set notification-bg             "#{{base00-hex}}"
            set notification-fg             "#{{base05-hex}}"
            set notification-warning-bg     "#{{base0A-hex}}"
            set notification-warning-fg     "#{{base05-hex}}"
            set notification-error-bg       "#{{base08-hex}}"
            set notification-error-fg       "#{{base05-hex}}"

            set index-bg                    "#{{base00-hex}}"
            set index-fg                    "#{{base05-hex}}"
            set index-active-bg             "#{{base07-hex}}"
            set index-active-fg             "#{{base05-hex}}"

            set default-bg                  "#{{base00-hex}}"
            set default-fg                  "#{{base05-hex}}"

            set inputbar-bg                 "#{{base00-hex}}"
            set inputbar-fg                 "#{{base0C-hex}}"
            set statusbar-bg                "#{{base00-hex}}"
            set statusbar-fg                "#{{base05-hex}}"

            set highlight-color             "#{{base0A-hex}}"
            set highlight-active-color      "#{{base06-hex}}"

            set recolor-lightcolor          "#{{base00-hex}}"
            set recolor-darkcolor           "#{{base05-hex}}"
          '';
        });
        rofi.theme = config.scheme {
          template = ''
            * {
                drac-bgd: #{{base00-hex}};
                drac-cur: #{{base07-hex}};
                drac-fgd: #{{base05-hex}};
                drac-cmt: #{{base03-hex}};
                drac-cya: #{{base0C-hex}};
                drac-grn: #{{base0B-hex}};
                drac-ora: #{{base0A-hex}};
                drac-pnk: #{{base0E-hex}};
                drac-pur: #{{base0D-hex}};
                drac-red: #{{base08-hex}};
                drac-yel: #{{base0A-hex}};

                font: "FiraCode Nerd Font 14";

                foreground: @drac-fgd;
                background-color: @drac-bgd;
                active-background: @drac-pnk;
                urgent-background: @drac-red;

                selected-background: @active-background;
                selected-urgent-background: @urgent-background;
                selected-active-background: @active-background;
                separatorcolor: @active-background;
                bordercolor: #6272a4;
            }

            #window {
                background-color: @background;
                border:           3;
                border-radius: 6;
                border-color: @bordercolor;
                padding:          25;
            }
            #mainbox {
                border:  0;
                padding: 5;
            }
            #message {
                border:       1px dash 0px 0px ;
                border-color: @separatorcolor;
                padding:      1px ;
            }
            #textbox {
                text-color: @foreground;
            }
            #listview {
                fixed-height: 0;
                border:       2px dash 0px 0px ;
                border-color: @bordercolor;
                spacing:      2px ;
                scrollbar:    false;
                padding:      2px 0px 0px ;
            }
            #element-text {
                border:  0;
                padding: 1px ;
                text-color:       @foreground;
            }
            #element-text normal.normal {
                background-color: @background;
            }
            #element-text normal.urgent {
                background-color: @urgent-background;
                text-color:       @urgent-foreground;
            }
            #element-text normal.active {
                backgroundr: @active-background;
            }
            #element-text selected.normal {
                background-color: @selected-background;
            }
            #element-text selected.urgent {
                background-color: @selected-urgent-background;
            }
            #element-text selected.active {
                background-color: @selected-active-background;
            }
            #element-text alternate.normal {
                background-color: @background;
            }
            #element-text alternate.urgent {
                background-color: @urgent-background;
            }
            #element-text alternate.active {
                background-color: @active-background;
            }
            #scrollbar {
                width:        2px ;
                border:       0;
                handle-width: 8px ;
                padding:      0;
            }
            #sidebar {
                border:       2px dash 0px 0px ;
                border-color: @separatorcolor;
            }
            #button selected {
                background-color: @selected-background;
                text-color:       @foreground;
            }
            #inputbar {
                spacing:    0;
                text-color: @foreground;
                padding:    1px ;
            }
            #case-indicator {
                spacing:    0;
                text-color: @foreground;
            }
            #entry {
                spacing:    0;
                text-color: @drac-cya;
            }
            #prompt {
                spacing:    0;
                text-color: @drac-grn;
            }
            #inputbar {
                children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
            }
            #textbox-prompt-colon {
                expand:     false;
                str:        ":";
                margin:     0px 0.3em 0em 0em ;
                text-color: @drac-grn;
            }
          '';
        };
        firefox.profiles."default" = {
          userChrome = with config.scheme; ''
            toolbar#nav-bar, nav-bar-customization-target {
              background: #${base00} !important;
            }
            @-moz-document url("about:newtab"),
            @-moz-document url("about:blank") {
              * { background-color: #${base00}  !important; }
            }
            #urlbar-background {
              background-color: #${base00} !important
            }
            #urlbar {
              color: #${base05} !important
            }
            #sidebar-splitter {
              border-color: #${base01} !important;
              color: #${base01} !important;
              background-color: #${base01} !important;
            }
          '';
          settings = with config.scheme; {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.anchor_color" = "#${base0D}";
            "browser.visited_color" = "#${base0C}";
          };
        };
      };
      xsession.windowManager.bspwm = {
        settings = with config.scheme.withHashtag; {
          focused_border_color = base0D;
          normal_border_color = base03;
          active_border_color = base03;
        };
      };
      services.polybar = {
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
