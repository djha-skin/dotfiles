# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
export PROFILE_INCLUDED=1

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/djhaskin987/perl5/bin:/home/djhaskin987/.local/bin"
export LANG="en_US.UTF-8"
export LOCALE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US:"

if [ -n "${JAVA_HOME}" ]
then
    export PATH="${PATH}:${JAVA_HOME}/bin"
fi

if [ -n "${GEM_HOME}" ]
then
    export PATH="${PATH}:${GEM_HOME}/bin"
fi

export JAVA_HOME="/home/djhaskin987/.apps/graalvm-ce-java11-20.0.0"

export home_altprefix="${HOME}/.apps"

for i in $(ls -1A ${home_altprefix})
do
    if [ -d "${home_altprefix}/${i}" -a -d "${home_altprefix}/${i}/bin" ]
    then
        export PATH="${PATH}:${home_altprefix}/${i}/bin"
    fi
done

export EDITOR="vim"
export ALTERNATE_EDITOR=""
export BROWSER="google-chrome"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=1000
export HISTFILESIZE=2000

for i in $(ls -1A ${HOME}/.gem/ruby)
do
    if [ -d "${HOME}/.gem/ruby/${i}/bin" ]
    then
        export PATH="${HOME}/.gem/ruby/${i}/bin:${PATH}"
    fi
done

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

# Periodically remove bash history for safety reasons
if [ -f "${HOME}/.bash_history" ]
then
    rm -f "${HOME}/.bash_history"
fi
