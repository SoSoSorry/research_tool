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
during_time=$3

thread_min=$4 #128*1024
thread_max=$5 #16*1024*1024*1024

#generate the packets;
for (( i=$thread_min; i<=$thread_max; i*=2)); do
  echo " "
  echo "------ connection: $i ------"
  if [ $# == 5 ]; then
    echo "iperf -c $ip -p $port -P $i -t $during_time -e"
    iperf -c $ip -p $port -P $i -t $during_time -e
  else
    namespace=$6
    echo "ip netns exec $namespace iperf -c $ip -p $port -P $i -t $during_time -e"
    ip netns exec $namespace iperf -c $ip -p $port -P $i -t $during_time -e
  fi
  echo "------ connection: $i. End ------"
  sleep 2
done

echo "------ $0 ------"


