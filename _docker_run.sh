#!/bin/bash

target=$1

shift 1

echo "Mounting WebDAV..."
mount /mnt/webdav

if [[ $? != 0 ]]; then
    echo "Mounting WebDAV failed. Exiting.."
    exit 1
fi
echo "Mounting successful.."

if ! [[ -d /mnt/webdav/$target ]]; then
    echo "Target WebDAV folder $target is missing. Exiting.."
    exit 2
fi

echo "Start RSync.."
echo 
rsync -azv \
	--size-only \
	--no-owner \
	--no-group \
	--no-perms \
    --exclude '.git/***' \
    --exclude '_env/***'  \
    --exclude '__pycache__/***'  \
    --exclude '.pytest_cache/***'  \
    --exclude '.ipynb_*/***'  \
    --exclude 'site-packages/***'  \
    --exclude 'jupyter/lab/***'  \
    --exclude '.pytest/***'  \
    /source/ /mnt/webdav/$target $@

if [[ "$@" != *"--dry-run"* ]]; then

    let sleeper=60*10*6
    echo "It's $(date +'%Y-%m-%d %H:%M:%S')"
    echo "Sleeping til $(date +'%Y-%m-%d %H:%M:%S' -d "+$sleeper sec") ..."
    sleep $sleeper
fi

echo done
