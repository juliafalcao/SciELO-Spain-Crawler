### bash script to compile the Java code into a custom build of this crawler,
### as opposed to the pre-packaged version from the GitHub repo (which is in `exec/`)

cd ~/scielo-crawler

# delete existing build
rm -rf Crawler.jar Crawler/

# copy all .jar dependencies from the original project into the root dir
cp exec/Scielo-Spain-Crawler_lib/* .

# compile subfolders
javac -cp code/:jsoup-1.10.3.jar:ixa-pipe-tok-1.8.5-exec.jar:commons-io-2.6.jar -d code/ code/File_Managers/*.java
javac -cp code/:jsoup-1.10.3.jar:ixa-pipe-tok-1.8.5-exec.jar:commons-io-2.6.jar -d code/ code/Full_Text_Extractor/*.java

# compile main folder
javac -cp code/:jsoup-1.10.3.jar:ixa-pipe-tok-1.8.5-exec.jar:commons-io-2.6.jar -d code/ code/*.java

# move the build folder from code/ into the root dir
mv code/Crawler/ Crawler/

# create MANIFEST.MF copy from the original
cp code/MANIFEST.MF Crawler/MANIFEST.MF

# compile into executable .jar file
jar cfmv Crawler.jar Crawler/MANIFEST.MF Crawler/**/*.class Crawler/*.class
