#!/bin/bash

source ~/.bashrc
# sudo docker container start search-v4-sg-temp
# sudo docker container start search-v4-vn-temp
sudo docker container start redis
sudo docker container start mongo

sudo ip link set enp6s0 mtu 1000
sudo ip link set wlp3s0 mtu 1000

# for keycron keyboard, enable f1/f2/... keys
echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode

# start vpn
nmcli con up id '99 VPN Dev'

# restart nginx
sudo service nginx stop
sudo service nginx start
