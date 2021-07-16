#!/bin/sh

install_dot() {
	echo "installing $1 to $2..."
	ln -sfb $1 $2
}

remove_dot() {
	echo "removing $1..."
	unlink $1 2> /dev/null

	if [ $? -gt 0 ]; then
		unlink "$(echo $1 | rev | cut -c 2- | rev)"
	fi
}

show_help() {
	echo "Usage: ./dot.sh [OPTION]... [FILE]..."
	echo " "
	echo "-i, --install	install dotfile"
	echo "-r, --remove	remove dotfile"
	echo "-h, --hooks	run hooks (TODO)"
	echo "-s, --show	print installed and not installed dotfiles (TODO)"
	echo " "
	echo "Run this script inside your dotfiles directory."
	echo "This script creates backups with ln -b."
}

# ./dot.sh --install .config/{dot1,dot2,dot3}

# main() {
case $1 in
	-i | --install)
		shift 
		for arg in "$@"; do
			install_dot "$(pwd)/$arg" "$HOME/$(echo $arg | sed s/"$(basename $arg)"//)"
		done
		;;
	-r | --remove)
		shift 
		for arg in "$@"; do
			remove_dot "$HOME/$arg"
		done
		;;
	*) 
		show_help 
		;;
esac
# }
