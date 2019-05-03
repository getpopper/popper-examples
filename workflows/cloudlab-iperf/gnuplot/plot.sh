#!/usr/bin/env sh
set -ex
wf_dir=${GITHUB_WORKSPACE}/workflows/cloudlab-iperf

cat "$wf_dir/results/iperf.out" | grep KBytes | awk '{ print $3"\t"$5"\t"$7"\t"$9 }' > $wf_dir/results/iperf.dat

gnuplot \
  -e "input_file='$wf_dir/results/iperf.dat'; output_path='$wf_dir/results'" \
  -p "${wf_dir}/gnuplot/graph-tcp-data.p"
