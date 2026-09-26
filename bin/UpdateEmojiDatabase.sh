#!/usr/bin/env sh

set -xe

EMOJI_DB_DIR=${XDG_CACHE_HOME:-~/.cache/}

[ -d $EMOJI_DB_DIR ] || mkdir -p $EMOJI_DB_DIR

EMOJI_DB_FILE="$EMOJI_DB_DIR/unicode_emoji.db.txt"

curl --silent 'https://unicode.org/Public/emoji/latest/emoji-test.txt' | cut -d '#' -f 2 -s | sed 's/^ *//' | grep -P '^[^[:alnum:]•©].*' > $EMOJI_DB_FILE

