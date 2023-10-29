#!/bin/bash
echo "------ $0 ------"
#1.build underlay network
IP_underlay=$1  #172.16.10.53
INT_underlay=$2 #"enp3s0"
netmask=$3      #24
prefix="LM"
ifconfig $INT_underlay $IP_underlay/$netmask

echo "underlay: int[$INT_underlay], ip[$IP_underlay]"

#2.build the vxlan
IP_local=$IP_underlay
IP_remote=$4   #172.16.10.155
ID=$5          #42 

ip link add ${prefix}_vxlan0 type vxlan \
id $ID \
dstport 4789 \
local $IP_local \
remote $IP_remote \
dev $INT_underlay

echo "vxlan: name[${prefix}_vxlan0], id[$ID], local_ip[$IP_local], remote_ip[$IP_remote]"

#3.build the route and connection.
brctl addbr ${prefix}_br0 type bridge
ifconfig ${prefix}_br0 up
ifconfig ${prefix}_vxlan0 up

brctl addif ${prefix}_br0 ${prefix}_vxlan0
#ip link add ${prefix}_br0 type bridge
#ip link set ${prefix}_vxlan0 master ${prefix}_br0
#ip link add ${prefix}_vrf0 type vrf table 10   #virtual route table
#ip link set ${prefix}_br0 master ${prefix}_vrf0

#ip link set ${prefix}_vxlan0 up
#ip link set ${prefix}_br0 up
#ip link set ${prefix}_vrf0 up

echo "bridge: name[${prefix}_br0]"
echo "virtual router table: name [${prefix}_vrf0]"

#4.build the overlay network
IP_overlay=$6 #"192.168.200.2"
netmask=$7    #24
ip netns add ${prefix}_ns0

ip link add ${prefix}_veth0 type veth peer name eth0 netns ${prefix}_ns0
ip link set ${prefix}_veth0 master ${prefix}_br0
ip link set ${prefix}_veth0 up

ip -n ${prefix}_ns0 link set lo up
ip netns exec ${prefix}_ns0 ifconfig eth0 $IP_overlay/$netmask
#ip -n ${prefix}_ns0 addr add $IP_overlay/$netmask dev eth0
ip -n ${prefix}_ns0 link set eth0 up

echo "veth: name [${prefix}_veth0, peer_app [eth0], peer_network[${prefix}_br0]"echo "namespace : name [${prefix}_ns0]"
echo "------ $0.end ------"
