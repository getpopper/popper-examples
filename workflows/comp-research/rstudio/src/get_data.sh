#!/bin/sh
cd $1

wget "https://drivendata-prod.s3.amazonaws.com/data/66/public/test_set_features.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARVBOBDCY3EFSLNZR%2F20200928%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200928T210959Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=3c0c7858eb58999ea46fe16dedd4debd96b46e5561145da7012ec677dd4aa5d3" 
wget "https://drivendata-prod.s3.amazonaws.com/data/66/public/training_set_features.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARVBOBDCY3EFSLNZR%2F20200928%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200928T210959Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=b4d3611239c93e2a354779b9e006c2440400af0b4df44707a45dc9babf81447a"
wget "https://drivendata-prod.s3.amazonaws.com/data/66/public/training_set_labels.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARVBOBDCY3EFSLNZR%2F20200928%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200928T210959Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=636630b31fbd10273dc406d1c5415c8696329bc21695f9deed7ac4756629f2e5"

echo "Files downloaded: $(ls)"
 