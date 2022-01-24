{ pkgs }:

pkgs.writeShellApplication {
  name = "git-switch";

  runtimeInputs = with pkgs; [ git fzf ];

  text = ''
    case "$(printf "GitHub\nUniversity" | fzf --prompt "Account: " --height 5)" in
      "GitHub")
        user="MoritzBoehme"
        email="mail@moritzboeh.me"
        key="0x213820E2795F5CF5"
        ;;

      "University")
        user="Moritz Boehme"
        email="mb18cele@studserv.uni-leipzig.de"
        key="0xE07B20727F85831C"
        ;;

      *)
        echo "Invalid choice!"
        exit 1
        ;;
    esac


    git config --local user.name "$user"
    echo "Set username to \"$user\"."
    git config --local user.email "$email"
    echo "Set email to \"$email\"."
    git config --local user.signingkey "$key"
    echo "Set key to \"$key\"."
  '';
}
