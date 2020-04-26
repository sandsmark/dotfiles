#!/bin/sh -xe

## Install files

# normal dot files in ~
for file in vimrc bashrc gitconfig gitexcludes muttrc bcrc lsan.suppressions offlineimaprc lesskey inputrc; do
    rm -f ~/.$file
    ln -s $PWD/$file ~/.$file;
done

# ccache setup
mkdir -p ~/.ccache/
rm -f ~/.ccache/ccache.conf
ln -s $PWD/ccache.conf ~/.ccache/ccache.conf

# xdg configs in ~/.config
mkdir -p ~/.config/
for file in compton.conf; do
    rm -f ~/.$file
    ln -s $PWD/$file ~/config/.$file;
done

# vim tmp dir and plugins
mkdir -p ~/.vim/tmp/
mkdir -p ~/.vim/plugin/
for file in linuxsty.vim qml.vim; do
    rm -f ~/.vim/plugin/$file;
    ln -s $PWD/$file ~/.vim/plugin/$file;
done

# firejail sandboxing config
mkdir -p ~/.config/firejail/
for file in makepkg.profile; do
    rm -f ~/.config/firejail/;
    ln -s $PWD/$file ~/.config/firejail/$file;
done


## Setup for stuff

# bash apparently needs us to do this?
touch ~/.bash_history

# Update config in ~/.less from ~/.lesskey
lesskey
