#!/bin/bash

echo "------ $0 ------"
echo "the number of parameter: $#"
if [ $# -lt 5 ]; then                # ';' is  the end handle.
  echo "error: lack of parameters"
  echo "------ $0 ------"
  exit 1
fi
ip=$1 # 192.168.200.1
port=$2 # 9509
thread=$3

min_traffic_size=$4 #128*1024
max_traffic_size=$5 #16*1024*1024*1024

#generate the packets;
for (( i=$min_traffic_size; i<=$max_traffic_size; i*=10 )); do
  echo " "
  echo "------ msg_size: $i ------"
  if [ $# == 5 ]; then
    echo "iperf -c $ip -u -p $port -P $thread -b ${i}pps -l 100bit -e"
    iperf -c $ip -u -p $port -P $thread -b ${i}pps -l 100bit -e 
  else
    namespace=$6
    echo "ip netns exec $namespace iperf -c $ip -u -p $port -P $thread -b ${i}pps -l 100bit -e"
    ip netns exec $namespace iperf -c $ip -u -p $port -P $thread -b ${i}pps -l 100bit -e
  fi
  echo "------ msg_size: $i. End ------"
  sleep 2
done

echo "------ $0 ------"

 

