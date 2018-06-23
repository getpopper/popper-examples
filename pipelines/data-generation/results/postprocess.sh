#!/bin/bash
set -e -x

OUTDIR="`pwd`/baseliner_output"
CSVOUT="all.csv"

echo "" > $CSVOUT

# stressng
docker run --rm -v $OUTDIR/benchmark:/data/benchmark \
  ivotron/json-to-tabular:v0.0.5 \
    --jqexp '. | .metrics | .[] | [.stressor, ."bogo-ops-per-second-real-time"]' \
    --filefilter '.*stressng.*yml' \
    ./ >> $CSVOUT

# likwid
docker run --rm -v $OUTDIR/benchmark:/data/benchmark \
  ivotron/json-to-tabular:v0.0.5 \
    --jqexp '[leaf_paths as $path | {"key": $path | join("."), "value": getpath($path)}] | .[] | [.key, (.value | tonumber) ]' \
    --filefilter '.*output.*yml' \
    ./ >> $CSVOUT

# stream
docker run --rm -v $OUTDIR/benchmark:/data/benchmark \
  ivotron/json-to-tabular:v0.0.5 \
    --filefilter '.*stream.*std.out' \
    --shex " grep 'Copy:\\|Scale:\\|Add:\\|Triad' | sed 's/://' | awk '{ print tolower(\$1)\",\"\$2 }'" \
    ./ >> temp
sed -i -s 's/\(.*\),\(.*\),\(.*\),\(.*\),\(.*\),\(.*\)/\1,\2,\3,\5-\4,\6/' temp
cat temp >> $CSVOUT
rm temp

# mysql
docker run --rm -v $OUTDIR/benchmark:/data/benchmark \
  ivotron/json-to-tabular:v0.0.5 \
    --jqexp 'to_entries | map([.key, .value]) | .[] ' \
    --filefilter '.*mysqlslap.*json' \
    ./ >> all.csv

# redis
docker run --rm -v $OUTDIR/benchmark:/data/benchmark \
  ivotron/json-to-tabular:v0.0.5 \
    --filefilter '.*redisbench.*.csv' \
    ./ >> all.csv

# runtime-based ones
for w in comd hpccg lulesh miniamr miniaero minife pybench scikit-learn ssca zlog ; do
  docker run --rm -v $OUTDIR/benchmark:/data/benchmark \
    ivotron/json-to-tabular:v0.0.5 \
      --filefilter ".*$w.*runtime" \
      --shex "sed 's/\(.*\):\(.*\):\(.*\)/\1 \2 \3/' | awk '{ print \"$w,\"((\$1 * 3600) + (\$2 * 60) + \$3) }'" \
      ./ >> all.csv
done

# remove blank lines
sed '/^\s*$/d' all.csv > all.csv.tmp
mv all.csv.tmp all.csv
