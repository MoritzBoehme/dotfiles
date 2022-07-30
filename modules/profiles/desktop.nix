{ config
, lib
, pkgs
, ...
}:
with lib; {
  my = {
    # config
    yubikey.enable = true;
    wallpapers.enable = true;
    theming.enable = true;
    shell.aliases = {
      feh = "feh --auto-zoom --scale-down";
    };

    virtualisation = {
      podman.enable = true;
      libvirtd.enable = true;
    };

    programs = {
      adb.enable = true;
      bspwm.enable = true;
      code.enable = true;
      emacs.enable = true;
      firefox = {
        enable = true;
        overrides = {
          ## arkenfox overrides
          # automatic search
          "keyword.enabled" = true;
          "browser.search.suggest.enabled" = true;
          "browser.urlbar.suggest.searches" = true;

          # startup page
          "browser.startup.homepage" = "https://searxng.moritzboeh.me/";
          "browser.startup.page" = 1;

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
      };
      git.signing = true;
      gpg.enable = true;
      hub.enable = true;
      kitty.enable = true;
      ledger.enable = true;
      rofi.enable = true;
      spotify.enable = true;
      thunar.enable = true;
      zathura.enable = true;
    };

    services = {
      dunst.enable = true;
      kdeconnect.enable = true;
      openconnect.enable = true;
      openvpn.enable = true;
      picom.enable = true;
      printing.enable = true;
      redshift.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # nix
    nixpkgs-review-checks

    # ripping
    abcde
    handbrake
    picard

    # other
    anki
    calibre
    jellyfin-media-player
    keepassxc
    libreoffice
    logseq
    pavucontrol
    signal-desktop
    tlaplusToolbox
    vlc
  ];

  home-manager.users.moritz = {
    services.unclutter.enable = true;
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };
  services = {
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    # Remap capslock to esc and shift + capslock to capslock
    xserver.xkbOptions = "terminate:ctrl_alt_bksp,caps:escape_shifted_capslock";
  };
}
