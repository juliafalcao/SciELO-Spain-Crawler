mkdir output_data && cp exec/CC-licenses.txt output_data/

java \
    -cp jsoup-1.10.3.jar:ixa-pipe-tok-1.8.5-exec.jar:commons-io-2.6.jar \
    -jar Crawler.jar output_data/
