{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          ### Display ###

          # Which monitor should the notifications be displayed on.
          monitor = 0;

          # Display notification on focused monitor.  Possible modes are:
          #   mouse: follow mouse pointer
          #   keyboard: follow window with keyboard focus
          #   none: don't follow anything
          #
          # "keyboard" needs a window manager that exports the
          # _NET_ACTIVE_WINDOW property.
          # This should be the case for almost all modern window managers.
          #
          # If this option is set to mouse or keyboard, the monitor option
          # will be ignored.
          follow = "mouse";

          # The geometry of the window:
          #   [{width}]x{height}[+/-{x}+/-{y}]
          # The geometry of the message window.
          # The height is measured in number of notifications everything else
          # in pixels.  If the width is omitted but the height is given
          # ("-geometry x2"), the message window expands over the whole screen
          # (dmenu-like).  If width is 0, the window expands to the longest
          # message displayed.  A positive x is measured from the left, a
          # negative from the right side of the screen.  Y is measured from
          # the top and down respectively.
          # The width can be negative.  In this case the actual width is the
          # screen width minus the width defined in within the geometry option.
          geometry = "0x4-25+25";

          # Show how many messages are currently hidden (because of geometry).
          indicate_hidden = "yes";

          # Shrink window if it's smaller than the width.  Will be ignored if
          # width is 0.
          shrink = "no";

          # The transparency of the window.  Range: [0; 100].
          # This option will only work if a compositing window manager is
          # present (e.g. xcompmgr, compiz, etc.).
          transparency = "15";

          # The height of the entire notification.  If the height is smaller
          # than the font height and padding combined, it will be raised
          # to the font height and padding.
          notification_height = 0;

          # Draw a line of "separator_height" pixel height between two
          # notifications.
          # Set to 0 to disable.
          separator_height = 1;

          # Padding between text and separator.
          padding = 8;

          # Horizontal padding.
          horizontal_padding = 10;

          # Defines width in pixels of frame around the notification window.
          # Set to 0 to disable.
          frame_width = 0;

          # Defines color of the frame around the notification window.
          frame_color = "#282a36";

          # Define a color for the separator.
          # possible values are:
          #  * auto: dunst tries to find a color fitting to the background;
          #  * foreground: use the same color as the foreground;
          #  * frame: use the same color as the frame;
          #  * anything else will be interpreted as a X color.
          separator_color = "frame";

          # Sort messages by urgency.
          sort = "yes";

          # Don't remove messages, if the user is idle (no mouse or keyboard input)
          # for longer than idle_threshold seconds.
          # Set to 0 to disable.
          # A client can set the 'transient' hint to bypass this. See the rules
          # section for how to disable this if necessary
          idle_threshold = 120;

          ### Text ###

          font = "Monospace 10";

          # The spacing between lines.  If the height is smaller than the
          # font height, it will get raised to the font height.
          line_height = 0;

          # Possible values are:
          # full: Allow a small subset of html markup in notifications:
          #        <b>bold</b>
          #        <i>italic</i>
          #        <s>strikethrough</s>
          #        <u>underline</u>
          #
          #        For a complete reference see
          #        <https://developer.gnome.org/pango/stable/pango-Markup.html>.
          #
          # strip: This setting is provided for compatibility with some broken
          #        clients that send markup even though it's not enabled on the
          #        server. Dunst will try to strip the markup but the parsing is
          #        simplistic so using this option outside of matching rules for
          #        specific applications *IS GREATLY DISCOURAGED*.
          #
          # no:    Disable markup parsing, incoming notifications will be treated as
          #        plain text. Dunst will not advertise that it has the body-markup
          #        capability if this is set as a global setting.
          #
          # It's important to note that markup inside the format option will be parsed
          # regardless of what this is set to.
          markup = "full";

          # The format of the message.  Possible variables are:
          #   %a  appname
          #   %s  summary
          #   %b  body
          #   %i  iconname (including its path)
          #   %I  iconname (without its path)
          #   %p  progress value if set ([  0%] to [100%]) or nothing
          #   %n  progress value if set without any extra characters
          #   %%  Literal %
          # Markup is allowed
          format = ''
            %s %p
            %b'';

          # Alignment of message text.
          # Possible values are "left", "center" and "right".
          alignment = "left";

          # Vertical alignment of message text and icon.
          # Possible values are "top", "center" and "bottom".
          vertical_alignment = "center";

          # Show age of message if message is older than show_age_threshold
          # seconds.
          # Set to -1 to disable.
          show_age_threshold = 60;

          # Split notifications into multiple lines if they don't fit into
          # geometry.
          word_wrap = "yes";

          # When word_wrap is set to no, specify where to make an ellipsis in long lines.
          # Possible values are "start", "middle" and "end".
          ellipsize = "middle";

          # Ignore newlines '\n' in notifications.
          ignore_newline = "no";

          # Stack together notifications with the same content
          stack_duplicates = true;

          # Hide the count of stacked notifications with the same content
          hide_duplicate_count = false;

          # Display indicators for URLs (U) and actions (A).
          show_indicators = "yes";

          ### Icons ###

          # Align icons left/right/off
          icon_position = "left";

          # Scale small icons up to this size, set to 0 to disable. Helpful
          # for e.g. small files or high-dpi screens. In case of conflict,
          # max_icon_size takes precedence over this.
          min_icon_size = 0;

          # Scale larger icons down to this size, set to 0 to disable
          max_icon_size = 64;

          # Paths to default icons.
          # icon_path = /usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/

          ### History ###

          # Should a notification popped up from history be sticky or timeout
          # as if it would normally do.
          sticky_history = "yes";

          # Maximum amount of notifications kept in history
          history_length = 20;

          ### Misc/Advanced ###

          # dmenu path.
          dmenu = "${pkgs.rofi}/bin/rofi -p dunst";

          # Browser for opening urls in context menu.
          browser = "${pkgs.firefox}/bin/firefox -new-tab";

          # Always run rule-defined scripts, even if the notification is suppressed
          always_run_script = true;

          # Define the title of the windows spawned by dunst
          title = "Dunst";

          # Define the class of the windows spawned by dunst
          class = "Dunst";

          # Print a notification on startup.
          # This is mainly for error detection, since dbus (re-)starts dunst
          # automatically after a crash.
          startup_notification = false;

          # Manage dunst's desire for talking
          # Can be one of the following values:
          #  crit: Critical features. Dunst aborts
          #  warn: Only non-fatal warnings
          #  mesg: Important Messages
          #  info: all unimportant stuff
          # debug: all less than unimportant stuff
          verbosity = "mesg";

          # Define the corner radius of the notification window
          # in pixel size. If the radius is 0, you have no rounded
          # corners.
          # The radius will be automatically lowered if it exceeds half of the
          # notification height to avoid clipping text and/or icons.
          corner_radius = 0;

          # Ignore the dbus closeNotification message.
          # Useful to enforce the timeout set by dunst configuration. Without this
          # parameter, an application may close the notification sent before the
          # user defined timeout.
          ignore_dbusclose = false;

          ### Legacy

          # Use the Xinerama extension instead of RandR for multi-monitor support.
          # This setting is provided for compatibility with older nVidia drivers that
          # do not support RandR and using it on systems that support RandR is highly
          # discouraged.
          #
          # By enabling this setting dunst will not be able to detect when a monitor
          # is connected or disconnected which might break follow mode if the screen
          # layout changes.
          force_xinerama = false;

          ### mouse

          # Defines list of actions for each mouse event
          # Possible values are:
          # * none: Don't do anything.
          # * do_action: If the notification has exactly one action, or one is marked as default,
          #              invoke it. If there are multiple and no default, open the context menu.
          # * close_current: Close current notification.
          # * close_all: Close all notifications.
          # These values can be strung together for each mouse event, and
          # will be executed in sequence.
          mouse_left_click = "close_current";
          mouse_middle_click = "do_action, close_current";
          mouse_right_click = "close_all";
        };
        urgency_low = {

          background = "#282a36";
          foreground = "#6272a4";
          timeout = 10;
        };
        urgency_normal = {

          background = "#282a36";
          foreground = "#bd93f9";
          timeout = 10;
        };
        urgency_critical = {

          background = "#ff5555";
          foreground = "#f8f8f2";
          timeout = 0;
        };
      };
    };
  };
}
