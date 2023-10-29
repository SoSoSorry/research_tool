echo "------ $0 ------"
if [ $# -lt 3 ]; then
  echo "lack of parameters"
  echo "$0 app server/client"
  exit 1
fi
app=$1
id=$2
config_path=$3
if [ $# == 3 ]; then
  if [ $app == "iperf3" ] && [ $id == "server" ]; then
    envoy -c $config_path/1.iperf3_server.yaml -l debug
    echo "envoy -c $config_path/1.iperf3_server.yaml"
  elif [ $app == "iperf3" ] && [ $id == "client" ]; then
    envoy -c $config_path/2.iperf3_client.yaml
  elif [ $app == "sockperf" ] && [ $id == "server" ]; then
    envoy -c $config_path/3.sockperf_server.yaml
  elif [ $app == "sockperf" ] && [ $id == "client" ]; then
    envoy -c $config_path/4.sockperf_client.yaml
  elif [ $app == "fortio" ] && [ $id == "server" ]; then
    envoy -c $config_path/5.fortio_server.yaml
  elif [ $app == "fortio" ] && [ $id == "client" ]; then
    envoy -c $config_path/6.fortio_client.yaml
  else
    echo "Error: no the configuration file"
  fi
else
  namespace=$4
  if [ $app == "iperf3" ] && [ $id == "server" ]; then
    ip netns exec $namespace envoy -c $config_path/1.iperf3_server.yaml
  elif [ $app == "iperf3" ] && [ $id == "client" ]; then
    ip netns exec $namespace envoy -c $config_path/2.iperf3_client.yaml
  elif [ $app == "sockperf" ] && [ $id == "server" ]; then
    ip netns exec $namespace  envoy -c $config_path/3.sockperf_server.yaml
  elif [ $app == "sockperf" ] && [ $id == "client" ]; then
    ip netns exec $namespace envoy -c $config_path/4.sockperf_client.yaml
  elif [ $app == "fortio" ] && [ $id == "server" ]; then
    ip netns exec $namespace envoy -c $config_path/5.fortio_server.yaml
  elif [ $app == "fortio" ] && [ $id == "client" ]; then
    ip netns exec $namespace envoy -c $config_path/6.fortio_client.yaml
  else
    echo "Error: no the configuration file"
  fi
fi
echo "------- $0. end ------"
