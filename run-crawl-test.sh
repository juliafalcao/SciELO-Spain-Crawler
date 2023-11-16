rm -rf crawl-test && mkdir crawl-test && cp exec/CC-licenses.txt crawl-test/

java \
    -cp jsoup-1.10.3.jar:ixa-pipe-tok-1.8.5-exec.jar:commons-io-2.6.jar \
    -jar Crawler.jar crawl-test/ 1885-642X
