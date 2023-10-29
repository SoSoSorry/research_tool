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
thread=$3

qps=$4
json_file=$5
during_time=$6
#generate the packets;
echo -e "\033[43;37m ------ long tail latency ------ \033[0m"
if [ $# == 6 ]; then
  echo "fortio load -c $thread -qps $qps  -t $during_time -json $json_file $ip:$port"
  fortio load -c $thread -qps $qps  -t $during_time -json $json_file $ip:$port 
else
  namespace=$7
  echo "ip netns exec $namespace fortio load -c $thread -qps $qps  -t $during_time $ip:$port"
  ip netns exec $namespace fortio load -c $thread -qps $qps  -t $during_time -json $json_file $ip:$port
fi
echo -e "\033[43;37m ------ long tail latency. End ------ \033[0m"

echo "------ $0 ------"

 

