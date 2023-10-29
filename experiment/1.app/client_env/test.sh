#!/bin/bash

ip=192.168.100.2   #call the local interface
port=15006
thread=1
min_traffic_size=1024
max_traffic_size=65536
namespace="LM_ns0"

./1.iperf3_TS.sh $ip $port $thread $min_traffic_size $max_traffic_size $namespace
