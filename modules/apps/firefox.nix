{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz.programs.firefox = {
    enable = true;
    profiles."default" = {
      extraConfig = "\n";
      settings = {

        # Dont show warning when accessing about:config
        "browser.aboutConfig.showWarning" = false;

        # Default Privacy Settings
        "browser.contentblocking.category" = "strict";
        "privacy.donottrackheader.enabled" = true;

        # Hide bookmarks
        "browser.toolbars.bookmarks.visibility" = "never";

        # Smooth scrolling
        "general.smoothScroll.lines.durationMaxMS" = 125;
        "general.smoothScroll.lines.durationMinMS" = 125;
        "general.smoothScroll.mouseWheel.durationMaxMS" = 200;
        "general.smoothScroll.mouseWheel.durationMinMS" = 100;
        "general.smoothScroll.msdPhysics.enabled" = true;
        "general.smoothScroll.other.durationMaxMS" = 125;
        "general.smoothScroll.other.durationMinMS" = 125;
        "general.smoothScroll.pages.durationMaxMS" = 125;
        "general.smoothScroll.pages.durationMinMS" = 125;
        "mousewheel.min_line_scroll_amount" = 40;
        "mousewheel.system_scroll_override_on_root_content.enabled" = true;
        "mousewheel.system_scroll_override_on_root_content.horizontal.factor" =
          175;
        "mousewheel.system_scroll_override_on_root_content.vertical.factor" =
          175;
        "toolkit.scrollbox.horizontalScrollDistance" = 6;
        "toolkit.scrollbox.verticalScrollDistance" = 2;
      };
    };
  };
}
