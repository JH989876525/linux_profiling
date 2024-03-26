#!/bin/bash
# Copyright (c) 2024 innodisk Crop.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

FREQUENCY=${1:-10}
TIMES=${2:-10}
TOTAL_TIMES=$((FREQUENCY*TIMES))

function profiling_net {
    sar -n DEV $FREQUENCY $TIMES > profiling_net.log
}

function profiling_cpu {
    pidstat -U $TOTAL_TIMES > profiling_cpu.log
}

function profiling_mem {
    pidstat -r $FREQUENCY $TIMES > profiling_mem.log
}

function profiling_disk {
    iostat $FREQUENCY $TIMES > profiling_disk.log
}

function profiling_perf {
    perf record -F 99 -a -g -- sleep $TOTAL_TIMES
}

function draw_flame_graph {
    perf script | ./stackcollapse-perf.pl > out.perf-folded
    ./flamegraph.pl out.perf-folded > perf-kernel.svg
}

function cleanall {
    rm -rf \
    out.perf-folded \
    perf-kernel.svg \
    perf.data
}

# profiling_net

# profiling_cpu

# profiling_mem

# profiling_disk

# profiling_perf

# draw_flame_graph