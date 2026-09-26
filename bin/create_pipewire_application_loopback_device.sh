#!/usr/bin/env bash

set -xe

if [ $# -lt 1 ]; then
    echo 'You should provide application from which input will be copied to loopback device'
    exit 1
fi

pw-loopback -m '[ FL FR ]' --capture-props="media.class=Audio/Sink node.name='OBS_Virtual_Sink' node.description='OBS Virtual Sink'" &
OBSVirtualSinkJobNumber=$!

echo "Created OBS_Virtual_Sink with Job ID = $OBSVirtualSinkJobNumber"

# $1 can be founded by looking at ```pw-dump | grep node.name``` output.
echo -n "$1" -n 1233
pw-loopback -C "$1" -P "'OBS_Virtual_Sink'" &
LoopbackJobID=$!

echo "Created loopback from $1 to OBS_Virtual_Sink with Job ID = $LoopbackJobID"

while true
do
    echo 'Created jobs: '
    jobs
    read -p "Write 'quit' to destroy loopback device and exit: " shouldExit
    if [ $shouldExit == 'quit' ]; then
        break
    fi
done

kill $LoopbackJobID
kill $OBSVirtualSinkJobNumber
