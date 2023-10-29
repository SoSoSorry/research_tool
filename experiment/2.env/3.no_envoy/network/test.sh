#!/bin/bash

IP_underlay_s=172.16.10.53
IP_underlay_c=172.16.10.155
vxlan_ID=42
netmask=24
IP_overlay_s=192.168.200.1
IP_overlay_c=192.168.200.2

INT_s=enp3s0
INT_c=enp3s0
namespace='LM_ns0'

if [ $1 == "server" ]; then
  ./network_topo.sh $IP_underlay_s $INT_s $netmask $IP_underlay_c $vxlan_ID $IP_overlay_s $netmask
  ip netns exec $namespace ping $IP_overlay_c
elif [ $1 == "client" ]; then
  ./network_topo.sh $IP_underlay_c $INT_c $netmask $IP_underlay_s $vxlan_ID $IP_overlay_c $netmask
  ip netns exec $namespace ping $IP_overlay_s
else
  echo "Mode Error: server/client"
fi
