#!/bin/sh

if which wl-copy >/dev/null 2>&1
then
    copy="wl-copy"
    paste="wl-paste -n"
elif which pbcopy >/dev/null 2>&1
then
    copy="pbcopy"
    paste="pbpaste"
elif which xclip >/dev/null 2>&1
then
    copy="xclip -selection clipboard -i"
    paste="xclip -selection clipboard -o"
else
    copy="xsel -i -b"
    paste="xsel -o -b"
fi
