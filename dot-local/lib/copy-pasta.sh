#!/bin/sh

if which wl-copy >/dev/null 2>&1
then
    copy="wl-copy"
    paste="wl-paste -n"
elif which pbcopy >/dev/null 2>&1
then
    copy="pbcopy"
    paste="pbpaste"
elif which copy >/dev/null 2>&1
    copy="xclip -selection clipboard -i"
    copy="xclip -selection clipboard -o"
else
    copy="xsel -i -b"
    paste="xsel -o -b"
fi
