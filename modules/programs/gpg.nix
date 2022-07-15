{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.programs.gpg;
in
{
  options.my.programs.gpg = {
    enable = mkOption {
      default = true;
      type = types.bool;
      example = true;
    };
  };
  config = mkIf cfg.enable {
    home-manager.users.moritz.programs.gpg.enable = true;
    environment.shellInit = ''
      export GPG_TTY="$(tty)"
      gpg-connect-agent /bye
      export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
    '';
    programs = {
      ssh.startAgent = false;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };
}
