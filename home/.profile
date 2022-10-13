# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [[ $EUID -eq 0 ]]; then
    echo ".profile of users should not be sourced by root."
    exit 1
fi

export GTK_IM_MODULE=fcitx
export GTK_USE_PROFILE=1
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export EGL_PLATFORM=gbm
export SAL_USE_VCLPLUGIN=kde
export MOZ_USE_XINPUT2=1
#export GDK_DPI_SCALE=0.5
#export GDK_SCALE=2
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus # yes, it's fcitx

export LESSHISTSIZE=0
export LESSHISTFILE=/dev/null
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export ANDROID_SDK_ROOT="$HOME/Android/Sdk/"
export NODE_REPL_HISTORY=""
export NVM_DIR="$HOME/.nvm"
. "$HOME/opt/nvmstub"
export GOPATH="$HOME/.go"
export CCACHE_DIR="$HOME/.ccache"
export PATH="$HOME/bin:$HOME/.cargo/bin:$HOME/kde/src/kdesrc-build:$HOME/.cabal/bin:$HOME/.ghcup/bin:$HOME/.local/bin:$PATH"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

#lesspipe
export LESSOPEN="| /usr/bin/lesspipe %s";
export LESSCLOSE="/usr/bin/lesspipe %s %s";

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

#ruby
#eval "$(rbenv init)"
