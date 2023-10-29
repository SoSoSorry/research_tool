#!/bin/bash
source ../common_parameter.sh
path=`pwd`
echo "------ $path/$0 ------"
if [ $# == 0 ]; then
  echo "lack of parameters.(server/client)"
  exit 1
fi

if [ $1 == "server" ]; then
  ip=$IP_server
  port=$PORT_sockperf # 10000(iperf)
  namespace="LM_ns0"
  server_path="../../../../1.app/server_env"
  $server_path/sockperf.sh $ip $port $namespace
elif [ $1 == "client" ]; then
  ip=$IP_client
  port=$PORT_envoy_out
  thread=1
  min_msg_size=16 #128*1024
  max_msg_size=2048 #16*1024*1024*1024
  namespace="LM_ns0"
  client_path="../../../../1.app/client_env"

  log_path="../../../../4.result/$scene/2.latency/1.test_1T_1C_TS"
  if [ ! -d $log_path ]; then
    mkdir -p $log_path
  fi
  if [ ! -d $log_path/ext ]; then
    mkdir -p $log_path/ext
  fi

  file_name_prefix="baseline_latency_TS"
  file_handle_tool="../../../tool/file_handle.py"
  for (( i=0; i<5; i++)); do
    count=$i
    log_file="${file_name_prefix}_$count.log"
    $client_path/3.sockperf_MS.sh $ip $port $thread $min_msg_size $max_msg_size $namespace | tee $log_path/$log_file
    python3 $file_handle_tool $log_path/$log_file
  done
else
  echo "Mode Error: server/client"
fi



echo "------ $path/$0 End-------"

