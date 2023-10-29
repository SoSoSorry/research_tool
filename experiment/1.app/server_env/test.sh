#!/bin/bash

ip=192.168.200.1
port=10000
namespace="LM_ns0"

./iperf3.sh $ip $port $namespace
