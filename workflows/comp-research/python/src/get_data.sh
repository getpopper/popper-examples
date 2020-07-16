mkdir -p data.raw
cd data/raw
URLS = [TODO]

for url in URLS 
do 
    curl $url
done
echo "Files downloaded:"
ls