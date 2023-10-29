#!/bin/bash

namespace="LM_ns0"
name_br="LM_br0"
name_veth="LM_veth0"
name_vxlan="LM_vxlan0"

## 1. move network interface to main namespace
echo "the namespace :"
ip netns list
ip netns exec $namespace ip link set eth0 netns 1
ip netns exec $namespace ifconfig

## 2. remove netns
ip netns del $namespace # ip -all netns delete; ip netns | xargs -l {} sudo ip netns delete{}
echo "deleted namspace:"
ip netns list

## 3. remove veth
echo "the veth:"
ifconfig | grep veth
ip link del eth0 # ip link del LM_veth0
echo "deleted veth:"
ifconfig | grep veth

# 4. remove bridge
echo "the bridge:"
brctl show
echo "delete the interface:"
ip link set dev $name_vxlan nomaster
brctl show

ip link del $name_br
echo "deleted bridge:"
brctl show

## 5. remove vxlan
echo "the vxlan:"
ifconfig | grep vxlan

ip link del $name_vxlan
echo "deleted vxlan"
ifconfig | grep vxlan

## 6. recover the ip of underlay network interface. [selected]
