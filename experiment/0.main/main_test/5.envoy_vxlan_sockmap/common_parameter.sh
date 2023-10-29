#!/bin/bash
pwd=`pwd`
echo "$pwd/common_parameter.sh"

scene="5.envoy_vxlan_sockmap"
IP_server=192.168.200.1
IP_underlay_server=172.16.2.53
IP_underlay_client=172.16.2.155
IP_client=192.168.200.2
PORT_iperf=8080 #10000
PORT_sockperf=8080 #10001
PORT_fortio=8080 #10002
PORT_iperf_udp=8080 #10004

PORT_envoy_in=15001
PORT_envoy_out=15006

qps_min=1
qps_max=1000000
