#!/bin/env sh

set -xe

cat /dev/urandom | basenc --z85 | head -c 64

