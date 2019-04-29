#!/usr/bin/env sh
wf_dir="$GITHUB_WORKSPACE/workflows/cloulab-multisite-transfer/"

cat "$wf_dir/results/iperf.out" | grep KBytes | awk '{ print $3"\t"$5"\t"$7"\t"$9 }' > $wf_dir/results/iperf.dat

gnuplot \
  -e "input_file='$wf_dir/results/iperf.data'; output_path='$wf_dir/results/'" \
  < "$wf_dir/scripts/graph-tcp-data.p"
