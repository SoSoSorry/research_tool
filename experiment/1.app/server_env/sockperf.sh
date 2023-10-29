#!/bin/bash
echo "------ $0 ------"
echo "the number of parameter: $#"
if [ $# -lt 2 ]; then                # ';' is  the end handle.
  echo "error: lack of parameters"
  echo "------ $0 ------"
  exit 1
fi
ip=$1 # 192.168.200.1
port=$2 # 9508
#netstat -tulpn
if [ $# == 2 ]; then
  echo "sockperf sr -i $ip -p $port --tcp"
  sockperf sr -i $ip -p $port --tcp
else
  namespace=$3
  echo "ip netns exec $namespace sockperf sr -i $ip -p $port"
  ip netns exec $namespace sockperf sr -i $ip -p $port --tcp
fi
echo "------ $0 ------"
#!/bin/bash


