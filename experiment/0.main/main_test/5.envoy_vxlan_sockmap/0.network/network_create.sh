#!/bin/bash
source ../common_parameter.sh
path=`pwd`
echo "------ $path/$0 ------"
if [ $# == 0 ]; then
  echo "lack of parameters.(server/client)"
  exit 1
fi

IP_underlay_s=$IP_underlay_server
IP_underlay_c=$IP_underlay_client
vxlan_ID=42
netmask=24
IP_overlay_s=$IP_server
IP_overlay_c=$IP_client

INT_s="enp3s0"
INT_c="enp4s0"
namespace='LM_ns0'
network_path="../../../../2.env/$scene/network"

if [ $1 == "server" ]; then
  #$network_path/network_reset.sh
  $network_path/network_topo.sh $IP_underlay_s $INT_s $netmask $IP_underlay_c $vxlan_ID $IP_overlay_s $netmask
  ip netns exec $namespace ping $IP_overlay_c -c 5
elif [ $1 == "client" ]; then
  #$network_path/network_reset.sh
  $network_path/network_topo.sh $IP_underlay_c $INT_c $netmask $IP_underlay_s $vxlan_ID $IP_overlay_c $netmask
  ip netns exec $namespace ping $IP_overlay_s -c 5
else
  echo "Mode Error: server/client"
fi

ifconfig
echo "------ $path/$0 ------"
