#!/bin/bash
source ../common_parameter.sh
path=`pwd`
echo "------ $path/$0 ------"
if [ $# -lt 2 ]; then
  echo "lack of parameters.(server/client core_number)"
  exit 1
fi

core_num=$2
echo "$core_num"
location=$1
sudo taskset -c 1-$core_num ./0.envoy.sh $location
