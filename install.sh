#!/usr/bin/env bash

cd $(dirname $0)

git submodule init
git submodule update

pushd vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
popd

DOTFILES="vim vimrc screenrc bashrc"

for file in $DOTFILES; do
	ln -sfT $PWD/$file ~/.$file
done


