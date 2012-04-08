#!/usr/bin/env bash

cd $(dirname $0)

git submodule init
git submodule update

pushd .vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
popd

ln -sfT $PWD/.vim ~/.vim
ln -sfT $PWD/.vimrc ~/.vimrc
ln -sfT $PWD/.screenrc ~/.screenrc


