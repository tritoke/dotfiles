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
	case CHOICE in
		"y" )        ;;
		"Y" )        ;;
		*   ) return ;;
	esac

	[ -e "$location/$name" ] && rm "$location/$name"
	readlink -q "$location/$name" >/dev/null && rm "$location/$name"
	ln -s "$PWD/$file" "$location/$name"
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

	replace=$(echo "yes\nno" | dmenu -p "$message")
	[ "$replace" != "yes" ] && return

	[ -e "$location/$name" ] && rm "$location/$name"
	readlink -q "$location/$name" >/dev/null && rm "$location/$name"
	ln -s "$PWD/$file" "$location/$name"
}

if command -v dmenu
then
	installer=dmenuinstall
	bginstall="yes"
else
	installer=cmdinstall
fi

for file in shell/*
do $installer "$file"
done
$installer 'xinitrc'
$installer 'vim/vimrc'
$installer 'vim/init.vim' "$HOME/.config/nvim" 'yes'
[ "$bginstall" = "yes" ] && feh --bg-fill "$PWD/backgrounds/$(ls backgrounds | sort | dmenu -p "choose background: " -l 30)"
