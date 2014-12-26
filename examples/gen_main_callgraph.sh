#!/bin/bash

#
# Assumes run in top dir

set -e
radare2 -nq -c 'aa ; ag main > temp/main.dot' temp/similar1
xdot temp/main.dot
dot -Tpng -otemp/main.png temp/main.dot
eog temp/main.png
