#!/bin/bash

app="iperf3"
config_path="./config"
namespace="LM_ns0"
if [ $1 == "server" ] || [ $1 == "client" ]; then
  ./envoy_start.sh $app $1 $config_path $namespace
else
  echo "Mode error: server/client"
fi
