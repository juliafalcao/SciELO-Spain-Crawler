#!/bin/bash
#SBATCH --job-name=scielo-spain-crawl
#SBATCH -D .
#SBATCH --output=/home/bsc88/bsc88585/scielo-full-crawl.%j.out
#SBATCH --error=/home/bsc88/bsc88585/scielo-full-crawl.%j.err
#SBATCH --time=00-02:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1

# -----------------------------------------------------------------------------------------
# Script to run the full crawl of SciELO España,
# using (a customized version of) the SciELO-Spain-Crawler
# https://github.com/PlanTL-GOB-ES/SciELO-Spain-Crawler
# -----------------------------------------------------------------------------------------

SCIELO_OUTPUT_FOLDER=/gpfs/projects/bsc88/data/01-raw-collections/scielo-spain_es_20231114/


java \
    -cp jsoup-1.10.3.jar:ixa-pipe-tok-1.8.5-exec.jar:commons-io-2.6.jar \
    -jar Crawler.jar \
    $SCIELO_OUTPUT_FOLDER \
    1578-908X # only this journal for a first run
