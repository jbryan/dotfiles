#!/usr/bin/env bash

#Config

DOTFILES="
	vim 
	vimrc 
	screenrc 
	bashrc 
	bash_logout 
	profile 
	irbrc
	tmux.conf
	xmodmap
	rtorrent.rc
"


# Do the install
cd $(dirname $0)

git submodule init
git submodule update

for file in $DOTFILES; do
	echo "Linking $file"
	ln -sfT $PWD/$file ~/.$file
done


