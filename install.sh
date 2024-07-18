#!/bin/sh

hash() {
  loc=$1
  if [ -d $loc ]
  then find $loc -type f -exec sha256sum | cut -d' ' -f1 | sha256sum | cut -d' ' -f1
  else sha256sum $loc | cut -d' ' -f1
  fi
}

cmdinstall() {
	file=$1
	name=$(echo $file | rev | cut -d '/' -f 1 | rev)
	location=$2
	[ "$location" = "" ] && location="$HOME"
	nodot=$3
	[ "$nodot" = "" ] && name=".$name"

	if [ -e "$location/$name" ]
	then
    if [ "$(readlink $location/$name)" = "$PWD/$file" ]; then return; fi
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
    if [ "$(readlink $location/$name)" = "$PWD/$file" ]; then return; fi
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

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

for file in shell/*
do $installer "$file"
done
$installer xinitrc
$installer gitconfig
$installer xbindkeysrc
$installer scripts

for item in nvim lvim kitty
do $installer "$item" "$XDG_CONFIG_HOME" 'yes'
done

for tool in dunst zathura
do
  mkdir -p "$XDG_CONFIG_HOME/$tool"
  $installer "${tool}rc" "$XDG_CONFIG_HOME/$tool" 'yes'
done

for file in resources/*
do $installer "$file" "$XDG_DATA_HOME" 'yes'
done
