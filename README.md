# Overview
This repository contain the system profiling tools.

# Requirement
- [sysstat](https://github.com/sysstat/sysstat)
    ```bash
    ./configure
    make
    sudo make install
    ```
- perf

# Run
## Draw flame graph
```bash
# default testime is 60 second
sudo draw_flamegraph.sh <test-time>
# file "perf-kernel.svg" will be generate
```

## Profiling CPU/MEM/NET/DISK
```bash
# default frequency is 10 second
# default times is 10 times
sudo <case>_profiling.sh <record-frequency> <record-times>
# file "profiling_<case>.log" will be generate
```

# Reference
- https://github.com/sysstat/sysstat
- https://github.com/brendangregg/FlameGraph