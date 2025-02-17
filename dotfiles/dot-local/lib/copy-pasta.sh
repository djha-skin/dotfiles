#!/bin/sh

if which pbcopy >/dev/null 2>&1
then
    copy="pbcopy"
    paste="pbpaste"
# https://unix.stackexchange.com/a/325972/9696
elif [ "$(loginctl show-session $(loginctl | awk '/tty/ {print $1}') -p Type | awk -F= '{print $2}')" = "x11" ]
then
    if which xclip >/dev/null 2>&1
    then
        copy="xclip -selection clipboard -i"
        paste="xclip -selection clipboard -o"
    else
        copy="xsel -i -b"
        paste="xsel -o -b"
    fi
else
    if which wl-copy >/dev/null 2>&1
    then
        copy="wl-copy"
        paste="wl-paste -n"
    fi
fi
