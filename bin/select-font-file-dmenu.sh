#!/bin/env sh

set -xe

fc-list | dmenu -p 'Select font' -l 25 | cut -d ':' -f 1 | rev | cut -d '/' -f 1 | rev | xsel -i -sel clip

