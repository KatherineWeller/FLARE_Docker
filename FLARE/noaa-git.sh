#!/bin/bash

LOGFILE=/FLARE_Docker/SCCData/noaa-logs/git.log
TIMESTAMP=$(date +"%D %T")

echo -e "\n\n-------------- $TIMESTAMP --------------" 2>&1 | tee -a $LOGFILE

echo -e "\n\nPull the R Script from GitHub:\n" 2>&1 | tee -a $LOGFILE

cd /FLARE_Docker/SCCData/noaa-source #https://github.com/CareyLabVT/SCCData/tree/noaa-source
git pull 2>&1 | tee -a $LOGFILE
echo -e "\n" 2>&1 | tee -a $LOGFILE
for i in *.R; do Rscript $i 2>&1 | tee -a $LOGFILE; done

echo -e "\n\nGitHub Server:\n" 2>&1 | tee -a $LOGFILE

cd /FLARE_Docker/SCCData/noaa-data #https://github.com/CareyLabVT/SCCData/tree/noaa-data
#git pull &>> ~/data/SCCData/noaa-logs/git.log
git add *.*
git commit -m "$TIMESTAMP: Git Backup" 2>&1 | tee -a $LOGFILE
/FLARE_Docker/FLARE/git-retry.sh push -f 2>&1 | tee -a $LOGFILE

cd /FLARE_Docker/SCCData/fcre #https://github.com/CareyLabVT/noaa_gefs_forecasts/tree/fcre
#git pull &>> ~/data/SCCData/noaa-logs/git.log
git add .
git commit -m "$TIMESTAMP: Git Backup" 2>&1 | tee -a $LOGFILE
/FLARE_Docker/FLARE/git-retry.sh push -f 2>&1 | tee -a $LOGFILE

cd /FLARE_Docker/noaa_gefs_forecasts/sugg #https://github.com/CareyLabVT/noaa_gefs_forecasts/tree/sugg
#git pull &>> ~/data/SCCData/noaa-logs/git.log
git add .
git commit -m "$TIMESTAMP: Git Backup" 2>&1 | tee -a $LOGFILE
/data/FLARE/git-retry.sh push -f 2>&1 | tee -a $LOGFILE

cd /FLARE_Docker/noaa_gefs_forecasts/sunp #https://github.com/CareyLabVT/noaa_gefs_forecasts/tree/sunp
#git pull &>> ~/data/SCCData/noaa-logs/git.log
git add .
git commit -m "$TIMESTAMP: Git Backup" 2>&1 | tee -a $LOGFILE
/FLARE_Docker/FLARE/git-retry.sh push -f 2>&1 | tee -a $LOGFILE

echo -e "\n\nPush the Logs to GitHub:\n" 2>&1 | tee -a $LOGFILE

cd /FLARE_Docker/SCCData/noaa-logs #https://github.com/CareyLabVT/SCCData/tree/noaa-logs
git add .
git commit -m "$TIMESTAMP: Logs" 2>&1 | tee -a $LOGFILE
/FLARE_Docker/FLARE/git-retry.sh push -f 2>&1 | tee -a $LOGFILE
git add .
git commit -m "$TIMESTAMP: Logs" 2>&1 | tee -a $LOGFILE
/FLARE_Docker/FLARE/git-retry.sh push -f 2>&1 | tee -a $LOGFILE
