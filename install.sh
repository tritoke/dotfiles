#!/bin/sh

cmdinstall() {
	file=$1
	name=$(echo $file | rev | cut -d '/' -f 1 | rev)
	location=$2
	[ "$location" = "" ] && location="$HOME"
	nodot=$3
	[ "$nodot" = "" ] && name=".$name"

	if [ -e "$location/$name" ]
	then
		message="Do you want to replace your $name with the new one? (y/N): "
	else
		message="Do you want to install $name? (y/N): "
	fi

	echo -n $message
	read CHOICE
	case $CHOICE in
		y*    )        ;;
		Y*    )        ;;
		*     ) return ;;
	esac

	ln -sf "$PWD/$file" "$location/$name"
}

dmenuinstall() {
	file=$1
	name=$(echo $file | rev | cut -d '/' -f 1 | rev)
	location=$2
	[ "$location" = "" ] && location="$HOME"
	nodot=$3
	[ "$nodot" = "" ] && name=".$name"

	if [ -e "$location/$name" ]
	then
		message="Do you want to replace your $name with the new one?"
	else
		message="Do you want to install $name?"
	fi

	replace=$(echo "yes\nno\nexit" | dmenu -p "$message")
  [ "$replace" = "exit" ] && exit 
	[ "$replace" != "yes" ] && return

	ln -sf "$PWD/$file" "$location/$name"
}

if xset q 2>&1 >/dev/null
then
  if command -v dmenu 2>&1 >/dev/null
  then
    installer=dmenuinstall
  else
    installer=cmdinstall
  fi
else
  installer=cmdinstall
fi

for file in shell/*
do $installer "$file"
done
$installer 'xinitrc'
$installer 'gitconfig'
$installer 'nvim' "${XDG_CONFIG_HOME:-$HOME/.config}" 'yes'

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/dunst"
$installer 'dunstrc' "${XDG_CONFIG_HOME:-$HOME/.config}/dunst" 'yes'
$installer 'resources/emojis' "${XDG_DATA_HOME:-$HOME/.local/share}" 'yes'
$installer 'resources/gitmojis' "${XDG_DATA_HOME:-$HOME/.local/share}" 'yes'

