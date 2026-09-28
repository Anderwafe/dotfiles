#!/bin/env sh

set -xe

( wpctl set-volume @DEFAULT_AUDIO_SINK@ $(BCPVAL="$( echo $(wpctl get-volume @DEFAULT_AUDIO_SINK@) | cut -d ' ' -f 2 )"; for (( idx = 0 ; idx < 101 ; idx = $idx + 2 )) do echo "$idx%"; done | dmenu -l 10 || echo $BCPVAL) )

