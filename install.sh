#!/usr/bin/env bash

#Config

DOTFILES="
	vim 
	vimrc 
	screenrc 
	bashrc 
	bash_logout 
	bash_prompts
	profile 
	irbrc
	tmux.conf
	Xmodmap
	rtorrent.rc
	xsessionrc
	gitconfig
	psqlrc
"


# Do the install
cd $(dirname $0)

echo "Updating git ..."
git submodule init
git submodule update

echo
echo "Installing dotfiles ..."
for file in $DOTFILES; do
	echo "Linking $file"
	ln -sfT $PWD/$file ~/.$file
done


echo 
echo "Installing bin files ..."
pushd bin
mkdir -p ~/bin
for file in *; do
	echo "Linking $file"
	ln -sfT $PWD/$file ~/bin/$file
done
popd


# awesome
echo 
echo "Installing awesome config ..."
mkdir -p ~/.config/
ln -sfT $PWD/awesome ~/.config/awesome
