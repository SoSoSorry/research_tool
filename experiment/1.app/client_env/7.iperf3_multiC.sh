#!/bin/bash

echo "------ $0 ------"
echo "the number of parameter: $#"
if [ $# -lt 6 ]; then                # ';' is  the end handle.
  echo "error: lack of parameters"
  echo "------ $0 ------"
  exit 1
fi
ip=$1 # 192.168.200.1
port=$2 # 9509
during_time=$3

core_min=$4 #128*1024
core_max=$5 #16*1024*1024*1024
thread=$6 # 16
#generate the packets;
for (( i=$core_min; i<=$core_max; i*=2)); do
  echo " "
  echo "------ core: $i ------"
  if [ $# == 6 ]; then
    echo "taskset -c 1-$i iperf -c $ip -p $port -P $thread -t $during_time -e"
    taskset -c 1-$i iperf -c $ip -p $port -P $thread -t $during_time -e
  else
    namespace=$7
    echo "taskset -c 1-$i ip netns exec $namespace iperf -c $ip -p $port -P $thread -t $during_time -e"
    taskset -c 1-$i ip netns exec $namespace iperf -c $ip -p $port -P $thread -t $during_time -e
  fi
  echo "------ core: $i. End ------"
  sleep 2
done

echo "------ $0 ------"


