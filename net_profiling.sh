#!/bin/bash
# Copyright (c) 2024 innodisk Crop.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

FREQUENCY=${1:-10}
TIMES=${2:-10}
TOTAL_TIMES=$((FREQUENCY*TIMES))

BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

function profiling_net {
    sar -n DEV $FREQUENCY $TIMES > profiling_net.log
}

function cleanall {
    rm -rf profiling_net.log
}

function ProgressBar() {
    ### <number> <time>
    # Process data
    ((_progress=(${1}*10000/${2})/100))
    ((_done=(_progress*4)/10))
    ((_left=40-_done))
    # Build progressbar string lengths
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")
    # print progressbar
    if [ $((${1}%2)) -eq 0 ]; then
        printf "\rProgress : [${YELLOW}${_fill// /#}${_empty// /-}${NC}] ${_progress}%%"
    else
        printf "\rProgress : [${BLUE}${_fill// /#}${_empty// /-}${NC}] ${_progress}%%"
    fi
}

if [ $UID -ne 0 ] ; then
	echo -e "User \"root\" in need."
    exit
fi

cleanall

profiling_net &

SECONDS=0
while [ "${SECONDS}" -lt "${TOTAL_TIMES}" ]
do
    sleep 1
    ProgressBar "${SECONDS}" "${TOTAL_TIMES}"
done
printf "\n"

cat profiling_net.log