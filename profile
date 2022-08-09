# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
export PROFILE_INCLUDED=1
export HOME="/home/djhaskin987"
export home_altprefix="${HOME}/.apps"
# Set up PATH
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:${HOME}/perl5/bin"
for i in $(ls -1A "${home_altprefix}")
do
    if [ -d "${home_altprefix}/${i}" ]
    then
        if [ -d "${home_altprefix}/${i}/bin" ]
        then
            export PATH="${home_altprefix}/${i}/bin:${PATH}"
            if [ -f "${home_altprefix}/${i}/bin/java" ]
            then
                export JAVA_HOME="${home_altprefix}/${i}"
            fi
        else
            export PATH="${home_altprefix}/${i}:${PATH}"
        fi
    fi
done
if [ -n "${GEM_HOME}" ]
then
    export PATH="${PATH}:${GEM_HOME}/bin"
fi

for i in $(ls -1A ${HOME}/.gem/ruby)
do
    if [ -d "${HOME}/.gem/ruby/${i}/bin" ]
    then
        export PATH="${HOME}/.gem/ruby/${i}/bin:${PATH}"
    fi
done
if [ -n "${KREW_ROOT}" ]
then
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

export NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"

export PATH="${HOME}/.local/bin:${PATH}"

# Set up locale
export LANG="en_US.UTF-8"
export LOCALE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US:"
export GOBIN="${HOME}/.local/bin"


for i in $(ls -1A ${home_altprefix})
do
    if [ -d "${home_altprefix}/${i}" -a -d "${home_altprefix}/${i}/bin" ]
    then
        export PATH="${PATH}:${home_altprefix}/${i}/bin"
    fi
done

export EDITOR="nvim"
export ALTERNATE_EDITOR=""
export BROWSER="firefox"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=1000
export HISTFILESIZE=2000

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -z "${BASHRC_INCLUDED}" -a -s "${HOME}/.bashrc" ]
    then
        . ${HOME}/.bashrc
    fi
    # Bash, why
    # https://superuser.com/a/912098
    unset PROMPT_COMMAND
fi


if [ -f "${HOME}/.private_profile" ]
then
    . "${HOME}/.private_profile"
fi

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

export PARINIT="rTbgqR B=*/-.,?'_A_a_@ Q=_s>| W=_S"
