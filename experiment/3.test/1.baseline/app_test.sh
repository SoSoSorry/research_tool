#!/bin/bash
##3. build the application (such as iperf3, sockperf...)

if [ $1 == "server" ]; then
  ip=192.168.200.1
  port=10000
  namespace="LM_ns0"
  server_path="../../1.app/server_env"
  $server_path/iperf3.sh $ip $port $namespace
elif [ $1 == "client" ]; then
  ip=192.168.200.2
  port=15006
  thread=1
  min_traffic_size=1024
  max_traffic_size=65536
  namespace="LM_ns0"
  client_path="../../1.app/client_env"
  $client_path/1.iperf3_TS.sh $ip $port $thread $min_traffic_size $max_traffic_size $namespace
else
  echo "Mode Error: server/client"
fi

