#!/bin/sh
cd data/raw

wget "https://s3.amazonaws.com/drivendata-prod/data/66/public/test_set_features.csv"
wget "https://s3.amazonaws.com/drivendata-prod/data/66/public/training_set_labels.csv"
wget "https://s3.amazonaws.com/drivendata-prod/data/66/public/training_set_features.csv"

echo "Files downloaded:"
ls 