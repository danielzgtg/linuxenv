# Called by SSH/TTY login but not gdm3

if [[ $EUID -eq 0 ]]; then
    echo '.profile of users should not be sourced by root.'
    exit 1
fi

for x in ~/.config/environment.d/*; do
    . "$x"
done

if [ -n "$BASH_VERSION" ]; then
    . ~/.bashrc
fi
