#!/bin/sh
echo [`date '+%Y-%m-%d %H:%M:%S'`] `hostname` start...



# /sbin/init

# run the command given as arguments from CMD
exec "$@"
