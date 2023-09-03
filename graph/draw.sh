#!/bin/bash
#introduction
python3 bar.py ./data/introduction/sidecar_latency.json  ./result_20220927/introduction/sidecar_latency.pdf 2
python3 bar.py ./data/introduction/sidecar_throughput.json  ./result_20220927/introduction/sidecar_throughput.pdf 1

#motivation
python3 bar.py ./data/motivation/bf2_latency.json  ./result_20220927/motivation/bf2_latency.pdf 2
python3 bar.py ./data/motivation/bf2_throughput.json  ./result_20220927/motivation/bf2_throughput.pdf 1

python3 fortio.py ./data/motivation/bf2_fortio.json ./result_20220927/motivation/bf2_fortio.pdf 4500 130
python3 fortio.py ./data/motivation/sidecar_fortio.json ./result_20220927/motivation/sidecar_fortio.pdf 18000 130

#evaluation
python3 plot.py ./data/evaluation/l2_forwarding_latency.json ./result_20220927/evaluation/l2_forwarding_latency.pdf 
python3 plot.py ./data/evaluation/l2_forwarding_throughput.json ./result_20220927/evaluation/l2_forwarding_throughput.pdf

python3 bar.py ./data/evaluation/l3_connection_throughput.json  ./result_20220927/evaluation/l3_connection_throughput.pdf 2
python3 bar.py ./data/evaluation/l7_qps_connection.json  ./result_20220927/evaluation/l7_qps_connection.pdf 2
python3 bar.py ./data/evaluation/l7_qps_latency_avg.json  ./result_20220927/evaluation/l7_qps_latency_avg.pdf 2
python3 bar.py ./data/evaluation/l7_qps_latency_99.json  ./result_20220927/evaluation/l7_qps_latency_99.pdf 1 right
python3 bar.py ./data/evaluation/l7_qps_qps.json  ./result_20220927/evaluation/l7_qps_qps.pdf 1
python3 ./bar_add.py ./data/evaluation/l2_forwarding_CPU.json ./result_20220927/evaluation/l2_forwarding_CPU.pdf 1
