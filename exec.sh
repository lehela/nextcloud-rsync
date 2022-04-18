#!/bin/bash
user=$1
source=$2
target=$3

shift 3

if [[ $target == "" ]]
then 
    echo "arg1 = goocloud user, e.g. leif"
    echo "arg2 = absolute source path, e.g. ~/development/"
    echo "arg3 = relative path in goocloud user's home folder, e.g. Development/"
    echo "others = rsync flags, e.g. --dry-run"
    echo 
    echo "IMPORTANT: set the terminating / to paths!!"
    exit 0
fi

set -x
docker run --rm --privileged --cap-add=SYS_ADMIN --device /dev/fuse \
    --name goocloud-rsync-$user \
    -v /lib/modules:/lib/modules \
    -v /home/leif/development/goocloud-rsync:/host \
    -v $source:/source \
    lehela/goocloud-rsync-$user:latest \
    /host/_docker_run.sh $target $@