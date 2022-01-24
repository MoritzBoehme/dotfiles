{ pkgs }:

pkgs.writeShellApplication {
  name = "share";

  runtimeInputs = with pkgs; [ curl coreutils rofi p7zip xclip ];

  text = ''
    files="$(find "$PWD" -maxdepth 10 -type 'f' -not -path '*/.*' | rofi -dmenu -d 15 -p 'File to share')"
    password="$(rofi -dmenu -p 'Password for encryption')"
    zipname="$HOME/Downloads/share-$(date +"%Y-%m-%d").zip"
    if [[ $password == "" ]]; then
      args=""
    else
      args="-p""$password"""
    fi
    7z a "$zipname" "$files" "$args" -mx9 > /dev/null
    link="$(curl -s -F"file=@$zipname" 0x0.st)"
    echo "$link"
    echo "$link" | xclip -sel c
    rm "$zipname"
  '';
}
