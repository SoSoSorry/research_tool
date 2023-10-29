#!/bin/bash
path=`pwd`
echo "------ $path/$0 ------"
if [ $# == 0 ]; then
  echo "lack of parameters.(server/client)"
  exit 1
fi

if [ $1 == "server" ]; then
  ip=192.168.200.1
  port=10000
  namespace="LM_ns0"
  server_path="../../../../1.app/server_env"
  $server_path/iperf3.sh $ip $port $namespace
elif [ $1 == "client" ]; then
  ip=192.168.200.2
  port=15006
  during_time=10 # 30
  min_thread=1 #128*1024
  max_thread=64 #16*1024*1024*1024
  namespace="LM_ns0"
  client_path="../../../../1.app/client_env"

  log_path="../../../../4.result/2.envoy_no_vxlan/1.throughput/2.test_maxTS_maxC_T"
  if [ ! -d $log_path ]; then
    mkdir -p $log_path
  fi
  if [ ! -d $log_path/ext ]; then
    mkdir -p $log_path/ext
  fi

  file_name_prefix="baseline_throughput_T"
  file_handle_tool="../../../tool/file_handle.py"
  for (( i=0; i<5; i++)); do
    count=$i
    log_file="${file_name_prefix}_$count.log"
    $client_path/2.iperf3_C.sh $ip $port $during_time $min_thread $max_thread $namespace | tee $log_path/$log_file
    python3 $file_handle_tool $log_path/$log_file
  done
else
  echo "Mode Error: server/client"
fi



echo "------ $path/$0 End-------"

