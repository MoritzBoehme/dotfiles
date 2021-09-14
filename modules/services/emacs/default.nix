{ config, lib, pkgs, inputs, ... }:

let
  base = {
    programs.emacs.enable = true;
    programs.emacs.package = pkgs.emacsGit;
    services.emacs.enable = true;
    services.emacs.package = pkgs.emacsGit;

    xdg = {
      enable = true;
      configFile = {
        "doom" = {
          source = ./doom;
          recursive = true;
          onChange = ''
            #!/bin/sh
            DOOM="$HOME/.emacs.d"
            if [ ! -d "$DOOM" ]; then
              git clone https://github.com/hlissner/doom-emacs.git "$DOOM"
              "$DOOM/bin/doom" -y install
            fi

            "$DOOM/bin/doom" sync
          '';
        };
      };
    };

    home.packages = with pkgs; [
      ## Emacs itself
      binutils # native-comp needs 'as', provided by this
      # emacsPgtkGcc   # 28 + pgtk + native-comp
      # ((emacsPackagesNgGen emacsPgtkGcc).emacsWithPackages (epkgs: [
      #   epkgs.vterm
      # ]))

      ## Doom dependencies
      git
      (ripgrep.override { withPCRE2 = true; })
      gnutls # for TLS connectivity

      ## Optional dependencies
      fd # faster projectile indexing
      imagemagick # for image-dired
      zstd # for undo-fu-session/undo-tree compression
      nixfmt # for formating nix

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [
        en
        en-computers
        en-science
        de
      ]))
      # :checkers grammar
      languagetool
      # :tools lookup & :lang org +roam
      sqlite
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-medium
    ];
  };
in
{
  nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

  fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];

  home-manager.users.moritz = { ... }: (base);
}
