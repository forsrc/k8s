#!/bin/sh

/usr/sbin/init
systemctl restart autofs


# run the command given as arguments from CMD
exec"$@"
