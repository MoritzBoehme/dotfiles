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
    URL="https://api.nasdaq.com/api/quote/GME/info?assetclass=stocks"
    res=$(curl --user-agent 'Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0' -sf "$URL")

    close="$(jq '.["data"]["keyStats"]["PreviousClose"]["value"]' <<< "$res")"
    close="${close//[^0-9.]/}"
    current="$(jq '.["data"]["primaryData"]["lastSalePrice"]' <<< "$res")"
    current="${current//[^0-9.]/}"
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
    sleep 5 &
    sleep_pid=$!
    wait
done
