#!/usr/bin/env bash

sudo mkdir -p /persist/etc/NetworkManager
sudo cp -r {,/persist}/etc/NetworkManager/system-connections
sudo mkdir -p /persist/var/lib/NetworkManager
sudo cp /var/lib/NetworkManager/{secret_key,seen-bssids,timestamps} /persist/var/lib/NetworkManager/

sudo cp -r {,/persist}/etc/nixos
sudo cp {,/persist}/etc/adjtime
sudo cp {,/persist}/etc/NIXOS

sudo cp -r {,/persist}/etc/ssh
sudo cp {,/persist}/etc/shadow
