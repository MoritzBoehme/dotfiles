{ config, lib, pkgs, inputs, ... }:

with lib;
let
  myEmacs = with pkgs;
    ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages
      (epkgs: [ epkgs.vterm ]));
  cfg = config.modules.editors.emacs;
in {
  options.modules.editors = {
    emacs = mkOption {
      default = true;
      type = types.bool;
      example = false;
    };
  };
  config = mkIf cfg {
    fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];

    home-manager.users.moritz = {
      home.sessionPath = [ "/home/moritz/.config/emacs/bin/" ];
      services.emacs = {
        enable = true;
        package = myEmacs;
      };

      home.packages = with pkgs; [
        ## Emacs itself
        binutils # native-comp needs 'as', provided by this
        myEmacs

        ## Doom dependencies
        git
        (ripgrep.override { withPCRE2 = true; })
        gnutls # for TLS connectivity

        ## Optional dependencies
        fd # faster projectile indexing
        imagemagick # for image-dired
        zstd # for undo-fu-session/undo-tree compression

        ## Module dependencies
        # :checkers spell
        (hunspellWithDicts [
          hunspellDicts.en_GB-ize
          hunspellDicts.en_US
          hunspellDicts.de_DE
        ])

        # :checkers grammar
        languagetool

        # :tools lookup & :lang org +roam
        sqlite
        gcc # HACK to get emacsqlite binary

        wordnet
        graphviz

        # :lang latex & :lang org (latex previews)
        texlive.combined.scheme-full
        texlab

        # :lang nix
        nixfmt # for formating nix
        rnix-lsp

        # :lang markdown
        pandoc

        # :app everywhere
        xdotool
        xorg.xwininfo
        xclip
        xorg.xprop

        # :lang python
        nodePackages.pyright
        python-dev

        # :email
        mu
        isync

        # :lang ledger
        ledger
      ];
    };
  };
}
