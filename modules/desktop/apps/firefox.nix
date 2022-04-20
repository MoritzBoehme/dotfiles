{ config, lib, pkgs, inputs, ... }:
let
  arkenfox = builtins.readFile (inputs.arkenfox-userjs + "/user.js");
  overrides = {
    ## arkenfox overrides
    # automatic search
    "keyword.enabled" = true;
    "browser.search.suggest.enabled" = true;
    "browser.urlbar.suggest.searches" = true;

    # drm
    "media.eme.enabled" = true;

    # sanitisation
    "privacy.clearOnShutdown.history" = false;

    # disable letterboxing
    "privacy.resistFingerprinting.letterboxing" = false;

    ## OTHER
    # Dont show warning when accessing about:config
    "browser.aboutConfig.showWarning" = false;

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
    "mousewheel.system_scroll_override_on_root_content.horizontal.factor" = 175;
    "mousewheel.system_scroll_override_on_root_content.vertical.factor" = 175;
    "toolkit.scrollbox.horizontalScrollDistance" = 6;
    "toolkit.scrollbox.verticalScrollDistance" = 2;
  };

  fullUserJs = ''
    // Arkenfox user.js
    ${arkenfox}

    // Overrides
    ${lib.concatStrings (lib.mapAttrsToList (name: value: ''
      user_pref("${name}", ${builtins.toJSON value});
    '') overrides)}'';
in {
  home-manager.users.moritz.programs.firefox = {
    enable = true;
    profiles."default".extraConfig = fullUserJs;
  };
}
