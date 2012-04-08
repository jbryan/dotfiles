#!/usr/bin/env bash
pushd .vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
popd

ln -sfT $PWD/.vim ~/.vim
ln -sfT $PWD/.vimrc ~/.vimrc
ln -sfT $PWD/.screenrc ~/.screenrc


