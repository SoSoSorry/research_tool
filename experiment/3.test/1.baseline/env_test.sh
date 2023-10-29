#!/bin/bash
path=`pwd`
echo "------ $path/$0 ------"
if [ $# == 0 ]; then
  echo "lack of parameters.(server/client)"
  exit 1
fi
##1. build the network

IP_underlay_s=172.16.10.53
IP_underlay_c=172.16.10.155
vxlan_ID=42
netmask=24
IP_overlay_s=192.168.200.1
IP_overlay_c=192.168.200.2

INT_s=enp3s0
INT_c=enp3s0
namespace='LM_ns0'
network_path="../../2.env/1.baseline/network"

if [ $1 == "server" ]; then
  $network_path/network_reset.sh
  $network_path/network_topo.sh $IP_underlay_s $INT_s $netmask $IP_underlay_c $vxlan_ID $IP_overlay_s $netmask
  ip netns exec $namespace ping $IP_overlay_c -c 5
elif [ $1 == "client" ]; then
  $network_path/network_reset.sh
  $network_path/network_topo.sh $IP_underlay_c $INT_c $netmask $IP_underlay_s $vxlan_ID $IP_overlay_c $netmask
  ip netns exec $namespace ping $IP_overlay_s -c 5
else
  echo "Mode Error: server/client"
fi

##2. build the envoy

app="iperf3"
envoy_path="../../2.env/1.baseline/envoy"
config_path="$envoy_path/config"
namespace="LM_ns0"  
if [ $1 == "server" ] || [ $1 == "client" ]; then
  $envoy_path/envoy_start.sh $app $1 $config_path $namespace
else
  echo "Mode error: server/client"
fi


echo "------ $path/$0 End-------"
