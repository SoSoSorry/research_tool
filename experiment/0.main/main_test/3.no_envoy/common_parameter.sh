#!/bin/bash
pwd=`pwd`
echo "$pwd/common_parameter.sh"

scene="3.no_envoy"
IP_server=192.168.200.1
IP_client=192.168.200.2
PORT_iperf=10000
PORT_sockperf=10001
PORT_fortio=10002
PORT_iperf_udp=10004

PORT_envoy_in=15001
PORT_envoy_out=15006



##L7
qps_min=1
qps_max=1000000
