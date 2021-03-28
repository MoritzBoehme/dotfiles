#!/bin/bash

t=0
sleep_pid=0

toggle() {
    t=$(((t + 1) % 2))

    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
}

trap "toggle" USR1

while true; do
    URL="https://query1.finance.yahoo.com/v8/finance/chart/GME"
    res=$(curl -sf "$URL")

    close=$(jq '.["chart"]["result"][0]["meta"]["previousClose"]' <<< "$res")
    current=$(jq '.["chart"]["result"][0]["meta"]["regularMarketPrice"]' <<< "$res")
    shares="1.650981"
    buy="214"

    if [[ $t -eq 0 ]]; then 
        percent_long=$(bc <<< "scale=10;$current/$buy*100-100")
        percent=$(LC_NUMERIC="en_US.UTF8" printf "%.2f" "$percent_long")
        profit_long=$(bc <<< "scale=10;$shares*$current - $shares*$buy")
        profit=$(LC_NUMERIC="en_US.UTF-8" printf "%.2f" "$profit_long")
        output="Overall:"
    else
        percent_long=$(bc <<< "scale=10;$current/$close*100-100")
        percent=$(LC_NUMERIC="en_US.UTF-8" printf "%.2f" "$percent_long")
        profit_long=$(bc <<< "scale=10;$shares*$current - $shares*$close")
        profit=$(LC_NUMERIC="en_US.UTF-8" printf "%.2f" "$profit_long")
        output="Today:"
    fi

    if [[ "$percent" =~ "-" ]]; then
        output="$output  $percent%"
    else
        output="$output  $percent%"
    fi

    if [[ "$profit" =~ "-" ]]; then
        output="$output Loss: $profit\$"
    else
        output="$output Gain: $profit\$"
    fi

    echo "$output"
    sleep 2 &
    sleep_pid=$!
    wait
done
