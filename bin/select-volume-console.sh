#!/bin/env sh

# set -xe

( BCPVAL=`wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f 2`; for (( idx = 0 ; idx < 101 ; idx = $idx + 2 )) do echo $idx; done | fzf --bind 'focus:execute(wpctl set-volume @DEFAULT_AUDIO_SINK@ {}%)' || wpctl set-volume @DEFAULT_AUDIO_SINK@ $BCPVAL; )

