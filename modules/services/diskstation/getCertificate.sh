#! /usr/bin/env bash
set -euo pipefail

nix-shell -p openssl \
    --command "openssl s_client -showcerts -connect $1 </dev/null 2>/dev/null|openssl x509 -outform PEM > $2"
