{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {

    programs.zathura = {
      enable = true;
      options = {
        #
        # Startup Options
        #
        recolor = true;
        adjust-open = "width";

        #
        # Dracula Theme
        #
        completion-bg = "#282a36";
        completion-fg = "#ff79c6";
        completion-group-bg = "#282a36";
        completion-group-fg = "#6272a4";
        completion-highlight-bg = "#44475a";
        completion-highlight-fg = "#f8f8f2";

        notification-error-bg = "#ff5555";
        notification-error-fg = "#f8f8f2";
        notification-warning-bg = "#ffb86c";
        notification-warning-fg = "#44475a";
        notification-bg = "#282a36";
        notification-fg = "#f8f8f2";

        index-bg = "#282a36";
        index-fg = "#f8f8f2";
        index-active-bg = "#44475a";
        index-active-fg = "#f8f8f2";

        default-bg = "#44475a";
        default-fg = "#bd93f9";

        inputbar-bg = "#282a36";
        inputbar-fg = "#8be9fd";
        statusbar-bg = "#282a36";
        statusbar-fg = "#f8f8f2";

        #
        # Recolor settings
        #
        recolor-lightcolor = "#282a36";
        recolor-darkcolor = "#f8f8f2";

        font = "Jetbrains Mono 9";
      };
    };
  };
}
