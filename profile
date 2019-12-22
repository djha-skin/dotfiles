# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
export PROFILE_INCLUDED=1

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/games"
export LANG="en_US.UTF-8"
export LOCALE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US:"

define_dir() {
    name="${1}"
    shift
    value="${1}"
    shift
    export ${name}="${value}"
    mkdir -p "${value}"
}

define_dir home_prefix "${HOME}/.local"
define_dir home_exec_prefix "${home_prefix}"
define_dir home_bindir "${home_prefix}/bin"
# We're in the home directory.
define_dir home_sbindir "${home_prefix}/bin"
export home_lib="lib"
define_dir home_libdir "${home_prefix}/${home_lib}"
define_dir home_libexecdir "${home_prefix}/libexec"
define_dir home_datarootdir "${home_prefix}/share"

define_dir home_sysconfdir "${HOME}/.config"
define_dir home_sharedstatedir "${HOME}/.com"
define_dir home_localstatedir "${HOME}/.appdata"
define_dir home_runstatedir "${home_localstatedir}/run"
define_dir home_logdir "${home_localstatedir}/log"
chmod 0700 "${home_runstatedir}"
define_dir home_rundatadir "${home_localstatedir}/lib"
define_dir home_cachedir "${home_localstatedir}/cache"

define_dir home_includedir "${home_prefix}/include"
# Think "opt"
define_dir home_altprefix "${HOME}/.apps"

if [ -z "${LD_LIBRARY_PATH}" ]
then
    LD_LIBRARY_PATH="/usr/local/lib64:/usr/local/lib:/usr/lib64:/usr/lib"
fi
export LD_LIBRARY_PATH="${home_libdir}:${LD_LIBRARY_PATH}"

if [ -e "/run/user/$(id -u)/gnupg/S.gpg-agent.ssh" ]
then
    export SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"
else
    export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
fi

if [ -n "${JAVA_HOME}" ]
then
    export PATH="${JAVA_HOME}/bin:${PATH}"
fi

if [ -n "${GEM_HOME}" ]
then
    export PATH="${GEM_HOME}/bin:${PATH}"
fi
if [ -d "/snap/" ]
then
    for i in $(ls -1A /snap/)
    do
        if [ -d "/snap/${i}/current/bin" ]
        then
            export PATH="/snap/${i}/current/bin:${PATH}"
        fi
    done
fi

for i in $(ls -1A ${home_altprefix})
do
    if [ -d "${home_altprefix}/${i}" -a -d "${home_altprefix}/${i}/bin" ]
    then
        export PATH="${home_altprefix}/${i}/bin:${PATH}"
    fi
done

export PYTHONPATH="${HOME}/.python:${home_libdir}/python:/usr/lib/python:/usr/local/lib/python:${PYTHONPATH}"
export SAGE_PATH="${HOME}/.sage:${home_libdir}/sage:/usr/lib/sage:/usr/local/lib/sage:${SAGE_PATH}"

define_dir GOPATH "${HOME}/Development/go"
export PATH="${GOROOT}/bin:${GOPATH}/bin:${PATH}"
export PATH="${HOME}/.cargo/bin:${PATH}"
export PATH="${HOME}/.cabal/bin:${PATH}"

export EDITOR="vim"
export ALTERNATE_EDITOR=""
export BROWSER="firefox"
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=1000
export HISTFILESIZE=2000

if [ "$(uname)" != "Darwin" ]
then
    export GOROOT="${HOME}/.apps/go"
    export TERMCAP="${HOME}/.config/termcap"
    export GUI_EDITOR="/usr/bin/emacsclient"
    if [ -f "${home_sysconfdir}/user-dirs.dirs" ]
    then
        . "${home_sysconfdir}/user-dirs.dirs"
    elif [ -f "${home_sysconfdir}/user-dirs.conf" ]
    then
        . "${home_sysconfdir}/user-dirs.conf"
    fi

    # The following XDG variables are set according to the standard at
    # http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
    export XDG_DATA_HOME="${home_datarootdir}"
    export XDG_CONFIG_HOME="${home_sysconfdir}"
    export XDG_CACHE_HOME="${home_cachedir}"
    export XDG_RUNTIME_DIR="${home_runstatedir}"
    export XDG_DATA_DIRS="${XDG_DATA_HOME}:/usr/local/share:/usr/share"
    export XDG_CONFIG_DIRS="${XDG_CONFIG_HOME}:/etc/xdg"
    export XDG_DATA_DIRS="${home_datarootdir}:/usr/local/share/:/usr/share/"

    if [ -f "${home_sysconfdir}/dbus-session" ]
    then
        . "${home_sysconfdir}/dbus-session"
    fi
    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
        screen-256color) color_prompt=yes;;
    esac
    export JAVA_HOME="${HOME}/.apps/jdk1.8.0_131"
else
    export GUI_EDITOR="/usr/local/bin/emacsclient"
    export VAGRANT_DEFAULT_PROVIDER=vmware_fusion
    # Add Python x.x binaries to path
    for i in $(ls -1A ${HOME}/Library/Python)
    do
        if [ -d "${HOME}/Library/Python/${i}/bin" ]
        then
            export PATH="${HOME}/Library/Python/${i}/bin:${PATH}"
        fi
    done
fi

if [ -d ${HOME}/.gem/ruby ]
then
    for i in $(ls -1A ${HOME}/.gem/ruby)
    do
        if [ -d "${HOME}/.gem/ruby/${i}/bin" ]
        then
            export PATH="${HOME}/.gem/ruby/${i}/bin:${PATH}"
        fi
    done
fi

export PATH="${home_bindir}:${HOME}/bin:${HOME}/usr/bin:${PATH}"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -z "${BASHRC_INCLUDED}" -a -s "${HOME}/.bashrc" ]
    then
        . ${HOME}/.bashrc
    fi
fi

export LIBVIRT_DEFAULT_URI="qemu:///system"

#export VAGRANT_DEFAULT_PROVIDER=kvm


if [ -f "${HOME}/.private_profile" ]
then
    . "${HOME}/.private_profile"
fi

export PATH="$HOME/.cargo/bin:$PATH"
