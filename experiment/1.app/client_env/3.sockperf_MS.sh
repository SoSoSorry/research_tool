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

min_msg_size=$4 #128*1024
max_msg_size=$5 #16*1024*1024*1024

#generate the packets;
for (( i=$min_msg_size; i<=$max_msg_size; i*=2 )); do
  echo " "
  echo -e "\033[43;37m ------ msg_size: $i ------ \033[0m"
  if [ $# == 5 ]; then
    echo "sockperf ul --msg-size $i -i ip -p $port --tcp --full-rtt"
    sockperf ul --msg-size $i -i $ip -p $port --tcp --full-rtt
  else
    namespace=$6
    echo "ip netns exec $namespace sockperf ul --msg-size $i -i $ip -p $port --tcp --full-rtt"
    ip netns exec $namespace sockperf ul --msg-size $i -i $ip -p $port --tcp --full-rtt
  fi
  echo -e "\033[43;37m ------ msg_size: $i. End ------ \033[0m"
done

echo "------ $0 ------"

 

