#!/bin/bash

while true; do
    line=1

    for var in "$@"; do
        curl -s http://stockpage.10jqka.com.cn/spService/${var}/Header/realHeader \
            | gzip --decompress \
            | awk -F, '{print $6}' \
            | awk -F: '{printf "%s\n", $NF}' \
            | sed 's/"//g' \
            | xargs printf "\x1b[${line};1H\x1b[2K${var} : %s";
        line=$((line+1))
        sleep 1;
    done
done
