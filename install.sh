#!/bin/sh -xe

for file in vimrc bashrc gitconfig gitexcludes muttrc bcrc lsan.suppressions offlineimaprc lesskey inputrc; do
    rm -f ~/.$file
    ln -s $PWD/$file ~/.$file;
done

mkdir -p ~/.ccache/
rm -f ~/.ccache/ccache.conf
ln -s $PWD/ccache.conf ~/.ccache/ccache.conf

mkdir -p ~/.config/
for file in compton.conf; do
    rm -f ~/.$file
    ln -s $PWD/$file ~/config/.$file;
done

mkdir -p ~/.vim/tmp/
for file in linuxsty.vim qml.vim; do
    rm -f ~/.vim/plugin/$file;
    ln -s $PWD/$file ~/.vim/plugin/$file;
done

touch ~/.bash_history

# Update ~/.less from ~/.lesskey
lesskey
