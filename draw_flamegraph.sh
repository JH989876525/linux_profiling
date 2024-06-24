#!/bin/bash
# Copyright (c) 2024 innodisk Crop.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

TOTAL_TIMES=${1:-60}

BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

function profiling_perf {
    perf record -F 99 -a -g -- sleep $TOTAL_TIMES
    if [ $? -ne 0 ] ; then
        echo "perf tool error $?"
        exit
    fi
}

function draw_flame_graph {
    perf script | ./stackcollapse-perf.pl > out.perf-folded
    sync
    ./flamegraph.pl out.perf-folded > perf-kernel.svg
}

function cleanall {
    rm -rf \
    out.perf-folded \
    perf-kernel.svg \
    perf.data*
}

if [ $UID -ne 0 ] ; then
	echo -e "User \"root\" in need."
    exit
fi

cleanall

profiling_perf

sync

sleep 3

draw_flame_graph