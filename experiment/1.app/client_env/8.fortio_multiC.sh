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

min_core=$4
max_core=$5
qps=$6
during_time=$7

#generate the packets;
for (( i=$min_core; i<=$max_core; i*=2 )); do
  echo " "
  echo -e "\033[43;37m ------ qps: $i ------ \033[0m"
  if [ $# == 5 ]; then
    echo "taskset -c 1-$i fortio load -c $thread -qps $qps  -t $during_time $ip:$port"
    taskset -c 1-$i fortio load -c $thread -qps $qps  -t $during_time $ip:$port
  else
    namespace=$8
    echo "taskset -c 1-$i ip netns exec $namespace fortio load -c $thread -qps $qps  -t $during_time $ip:$port"
    taskset -c 1-$i ip netns exec $namespace fortio load -c $thread -qps $qps  -t $during_time $ip:$port
  fi
  echo -e "\033[43;37m ------ qps: $i. End ------ \033[0m"
done

echo "------ $0 ------"

 

