#!/bin/env sh

set -xe

fc-list | fzf | cut -d ':' -f 1 | rev | cut -d '/' -f 1 | rev

