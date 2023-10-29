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

min_qps=$4
max_qps=$5
during_time=$6
#generate the packets;
for (( i=$min_qps; i<=$max_qps; i*=10 )); do
  echo " "
  echo -e "\033[43;37m ------ qps: $i ------ \033[0m"
  if [ $# == 5 ]; then
    echo "fortio load -c $thread -qps $i  -t $during_time $ip:$port"
    fortio load -c $thread -qps $i  -t $during_time $ip:$port
  else
    namespace=$7
    echo "ip netns exec $namespace fortio load -c $thread -qps $i  -t $during_time $ip:$port"
    ip netns exec $namespace fortio load -c $thread -qps $i  -t $during_time $ip:$port
  fi
  echo -e "\033[43;37m ------ qps: $i. End ------ \033[0m"
done

echo "------ $0 ------"

 

