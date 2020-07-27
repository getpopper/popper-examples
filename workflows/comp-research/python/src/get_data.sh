#!/bin/sh
cd $1

wget "https://s3.amazonaws.com/drivendata-prod/data/66/public/test_set_features.csv" --no-check-certificate
wget "https://s3.amazonaws.com/drivendata-prod/data/66/public/training_set_labels.csv" --no-check-certificate
wget "https://s3.amazonaws.com/drivendata-prod/data/66/public/training_set_features.csv" --no-check-certificate

echo "Files downloaded: $(ls)"
