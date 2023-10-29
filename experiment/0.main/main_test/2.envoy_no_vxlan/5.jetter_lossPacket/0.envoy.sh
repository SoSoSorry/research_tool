#!/bin/bash
path=`pwd`
echo "------ $path/$0 ------"
if [ $# == 0 ]; then
  echo "lack of parameters.(server/client)"
  exit 1
fi

app="udp"
envoy_path="../../../../2.env/2.envoy_no_vxlan/envoy"
config_path="$envoy_path/config"
namespace="LM_ns0"
if [ $1 == "server" ] || [ $1 == "client" ]; then
  $envoy_path/envoy_start.sh $app $1 $config_path $namespace
else
  echo "Mode error: server/client"
fi

echo "------ $path/$0 ------"
