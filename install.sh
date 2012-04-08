#!/usr/bin/env bash
pushd .vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
popd

ln -sf $PWD/.vim ~/.vim
ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.screenrc ~/.screenrc


