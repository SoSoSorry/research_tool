#!/bin/bash
echo "------ $0 ------"
echo "the number of parameter: $#"
if [ $# -lt 2 ]; then                # ';' is  the end handle.
  echo "error: lack of parameters"
  echo "------ $0 ------"
  exit 1
fi
ip=$1 # 192.168.200.1
port=$2 # 9509
#netstat -tulpn
if [ $# == 2 ]; then
  iperf -s -B $ip -p $port -e
  echo "iperf -s -B $ip -p $port"
else
  namespace=$3
  ip netns exec $namespace iperf -s -B $ip -p $port -e
  echo "ip netns exec $namespace iperf -s -B $ip -p $port"
fi
echo "------ $0 ------"
