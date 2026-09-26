#!/bin/env sh

set -xe

EMOJI_DB_DIR=${XDG_CACHE_HOME:-~/.cache/}
EMOJI_DB_FILE="$EMOJI_DB_DIR/unicode_emoji.db.txt"

if [ ! -f $EMOJI_DB_FILE ]; then
    echo "No emoji database file found: $EMOJI_DB_FILE"
    exit 1
fi

cat $EMOJI_DB_FILE | fzf | cut -d ' ' -f 1 | tr -d '\n' | xclip -i -sel clip

