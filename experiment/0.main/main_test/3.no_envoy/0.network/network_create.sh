#!/bin/bash
source ../common_parameter.sh
path=`pwd`
echo "------ $path/$0 ------"
if [ $# == 0 ]; then
  echo "lack of parameters.(server/client)"
  exit 1
fi

IP_underlay_s=IP_underlay_server
IP_underlay_c=IP_underlay_client
vxlan_ID=42
netmask=24
IP_overlay_s=$IP_server
IP_overlay_c=$IP_client

INT_s="enp96s0f1np1"
INT_c="ens5f1np1"
namespace='LM_ns0'
network_path="../../../../2.env/$scene/network"

if [ $1 == "server" ]; then
  #$network_path/network_reset.sh
  $network_path/network_topo.sh $INT_s $IP_overlay_s $netmask
  ip netns exec $namespace ping $IP_overlay_c -c 5
elif [ $1 == "client" ]; then
  #$network_path/network_reset.sh
  $network_path/network_topo.sh $INT_c $IP_overlay_c $netmask
  ip netns exec $namespace ping $IP_overlay_s -c 5
else
  echo "Mode Error: server/client"
fi

ifconfig
echo "------ $path/$0 ------"
