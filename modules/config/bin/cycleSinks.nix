{ pkgs }:
pkgs.writeShellApplication {
  name = "cycle_sinks";

  runtimeInputs = with pkgs; [ pulseaudio ];
  text = ''
    # get the default sink
    default_sink="$(pactl info | grep -e "Default Sink:" | awk '{print $3}')"
    echo "current default: $default_sink"

    # get the sinks
    sinks="$(pactl list sinks short | awk '{print $2}')"

    # filter out the default sink
    not_active="$(echo "$sinks" | grep -v -e "$default_sink")"

    # get the sink after the dafault one
    next_sink="$(echo -e "$sinks\n$not_active" | grep -e "$default_sink" -A 1 | tail -n 1 )"

    # set the new default-sink
    pactl set-default-sink "$next_sink"
    echo "new default: $next_sink"
  '';
}
