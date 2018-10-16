#!/bin/sh

recover() {
    rm -rf /tmp/recover

    git clone -b $GIT_BRANCH $GIT_URL /tmp/recover

    rm -rf $VOLUME_PATH/.git
    mv /tmp/recover/.git $VOLUME_PATH/

    cd $VOLUME_PATH

    git fetch
    if [ $? -ne 0 ]; then
        echo "Unable to fetch from $GIT_URL"
        exit 1
    fi

    git reset --hard FETCH_HEAD
    if [ $? -ne 0 ]; then
        echo "Unable to git reset $VOLUME_PATH"
        exit 1
    fi
}

echo "[$(date +"%H:%M:%S")] === Start ==="

source /etc/update.env.sh

cd $VOLUME_PATH

# Get latest changes from upstream
if ! git status; then
    recover
fi

if git fetch; then
    # Make sure that there are no changes applied to that repository
    git reset --hard FETCH_HEAD
    if [ $? -ne 0 ]; then
        recover
    fi
else
    git reset --hard
    if [ $? -ne 0 ]; then
        recover
    fi
fi

echo -e "[$(date +"%H:%M:%S")] --- End ---\n"

