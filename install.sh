#!/usr/bin/env bash

cd $(dirname $0)

git submodule init
git submodule update

DOTFILES="vim vimrc screenrc bashrc bash_logout profile"

for file in $DOTFILES; do
	ln -sfT $PWD/$file ~/.$file
done


