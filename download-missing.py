# Script to download the HTML pages of the articles that failed to be downloaded as XML by the crawler
# (the XMLs downloaded were not complete)

# (!) folder path of where the crawler put its outputs
# absolute path or relative to crawler root (`output_data` for example)
OUTPUT_FOLDER = "output_data"

import os
import requests
from glob import glob
import asyncio

# to run in parallel threads
def background(f):
    def wrapped(*args, **kwargs):
        return asyncio.get_event_loop().run_in_executor(None, f, *args, **kwargs)
    return wrapped

os.chdir(os.path.join(OUTPUT_FOLDER, "full_texts/clean_xml_text/"))
journals = os.listdir()

# find records that failed
# (the XMLs don't have any <sentence> tags)
failed_record_ids = []

for journal in journals:
    files = glob(f"{journal}/*.xml")

    for file in files:
        xml = open(file).read()

        if "<sentence" not in xml:
            record_id = file.split("/")[1].replace(".xml", "")
            failed_record_ids.append(record_id)

# create folder for the HTMLs of the missing texts
os.chdir("..") # full_texts/
if "htmls" not in os.listdir():
    os.makedirs("htmls")

# function to download the html for a single record if it hasn't already been downloaded 
@background # (comment this to run sequentially)
def get_html(record_id):
    if f"{record_id}.html" in os.listdir("htmls"): # skip already done
        return

    url = f"https://scielo.isciii.es/scielo.php?script=sci_arttext&pid={record_id}"
    res = requests.get(url)

    if not res.ok: # http error
        print(f"[{record_id}] error: response {res.status_code}")
        return

    res.encoding = res.apparent_encoding # fix utf-8 encoding
    html = res.text

    if "<p>" not in html: # malformed html
        print(f"[{record_id}] error: no <p>s found")
        return

    with open(f"htmls/{record_id}.html", mode="w+") as fout:
        fout.write(html)

    print(f"created htmls/{record_id}.html")
    return

# loop over failed records and download each html
for record_id in failed_record_ids:
    get_html(record_id)

## to follow progress:
## cd htmls && watch -n 2 'ls -1 | wc -l'
