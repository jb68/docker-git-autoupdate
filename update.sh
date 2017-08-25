#!/bin/sh

echo "[$(date +"%H:%M:%S")] === Start ==="

source /etc/update.env.sh

cd $VOLUME_PATH

# Get latest changes from upstream
git fetch

# Make sure that there are no changes applied to that repository
git reset --hard FETCH_HEAD

echo -e "[$(date +"%H:%M:%S")] --- End ---\n"

