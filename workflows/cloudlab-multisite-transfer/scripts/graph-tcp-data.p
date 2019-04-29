# source: http://secretwafflelabs.com/2015/10/08/bandwidth-testing/
#
# gnuplot script to generate three graphs from iperfs data
# It is assumed the iperf data is captured in results.dat
# using this command:
# iperf3 -t 60 -c ${ip} | grep KBytes | awk '{ print $3"\t"$5"\t"$7"\t"$9 }' > results.dat

set term pdfcairo enhanced
set grid
unset key

set title "Data Transfer"
set ylabel "MBytes/sec"
set xlabel "Second"
set output output_path."/transfer.pdf"
plot input_file using 1:2 title 'Transfer' smooth csplines

set title "Packet Retries"
set ylabel "Count"
set output output_path."/retries.pdf"
plot input_file using 1:4 title 'ReTries' smooth csplines

set title "Bandwidth"
set ylabel "MBits/sec"
set yrange [0:1000]
set output output_path."/bandwidth.pdf"
plot input_file using 1:3 title 'Bandwidth' smooth csplines
