#!/bin/sh

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Ask a user for confirmation using read
# returns 1 on "no" and 0 on "yes"
# $1: message to ask
readask() {
    echo "$1 (yes/no/exit):"
    read -r choice
    case $choice in
        y* ) return 0 ;;
        Y* ) return 0 ;;
        e* ) exit     ;;
        E* ) exit     ;;
        *  ) return 1 ;;
    esac
}

# Ask a user for confirmation using dmenu
# returns 1 on "no" and 0 on "yes"
# $1: message to ask
dmenuask() {
    choice=$(printf "yes\nno\nexit" | dmenu -p "$1")
    case $choice in
        y* ) return 0 ;;
        Y* ) return 0 ;;
        e* ) exit     ;;
        E* ) exit     ;;
        *  ) return 1 ;;
    esac
}

# ask to install a file with a symlink:
# $1: relative path to the file to install
# $2: the directory to install the file into
# $3: the destination filename, defaults to basename of $1
ask_and_link() {
    file=$1
    name=$(basename "$file")
    location=$2
    destname=${3:-$name}

    if [ -e "$location/$destname" ]; then
        # if the link already exists then we are done
        if [ "$(readlink "$location/$destname")" = "$PWD/$file" ]; then
            echo "$name already installed" >&2
            return;
        fi

        message="Do you want to replace your $name with the new one?"
    else
        message="Do you want to install $name?"
    fi

    if $global_asker "$message"; then
        echo "Installing $name" >&2
        # make the directory if it doesn't exist
        mkdir -p "$location"

        ln -sf "$PWD/$file" "$location/$destname"
    else
        echo "Not installing $name" >&2
    fi
}

if xset q >/dev/null 2>&1 && command -v dmenu >/dev/null 2>&1; then
    global_asker=readask
else
    global_asker=readask
fi

for file in shell/* xinitrc gitconfig gitconfig-tritoke xbindkeysrc scripts; do
    ask_and_link "$file" "$HOME" ".$(basename "$file")"
done

for dir in "nvim" "lvim" "kitty"; do
    ask_and_link "$dir" "$XDG_CONFIG_HOME"
done

for tool in "dunst" "zathura"; do
    ask_and_link "${tool}rc" "$XDG_CONFIG_HOME/$tool"
done

for file in resources/*; do
    ask_and_link "$file" "$XDG_DATA_HOME"
done

ask_and_link "fonts.conf" "$XDG_CONFIG_HOME/fontconfig"
