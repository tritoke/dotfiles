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
		"y"   )        ;;
		"Y"   )        ;;
		"yes" )        ;;
		"Yes" )        ;;
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

	replace=$(echo -e "yes\nno\nexit" | dmenu -p "$message")
  [ "$replace" = "exit" ] && exit 
	[ "$replace" != "yes" ] && return

	ln -sf "$PWD/$file" "$location/$name"
}

if xset q &>/dev/null
then
  if command -v dmenu &>/dev/null
  then
    installer=dmenuinstall
    bginstall="yes"
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
$installer 'vim/vimrc'
$installer 'vim/init.vim' "$HOME/.config/nvim" 'yes'
$installer 'dunstrc' "$HOME/.config/dunst" 'yes'

if [ "$bginstall" = "yes" ] 
then
  while [ "$again" != "no" ]
  do
      background="$PWD/backgrounds/"$(ls backgrounds | sort | dmenu -p 'choose background: ' -l 30)
      feh --bg-fill "$background"
      again=$(echo -e 'yes\nno' | dmenu -p "Choose a different background? ")
  done
fi
