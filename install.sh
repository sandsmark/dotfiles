#!/bin/sh -xe

## Install files

# It's a folder, so clean it up manually first
rm -rf ~/.Xresources.d
rm -f "$PWD/Xresources.d/xft.dpi"
echo "Xft.dpi: $(xdpyinfo | grep dots | cut -d: -f2 | cut -dx -f1 | gawk '{ print $1; }')" > "$PWD/Xresources.d/xft.dpi"

# normal dot files in ~
for file in vimrc bashrc gitconfig gitexcludes muttrc bcrc lsan.suppressions offlineimaprc lesskey inputrc Xdefaults Xresources.d; do
    rm -f ~/.$file
    ln -s $PWD/$file ~/.$file;
done

# ccache setup
mkdir -p ~/.ccache/
rm -f ~/.ccache/ccache.conf
ln -s $PWD/ccache.conf ~/.ccache/ccache.conf

# Nuke old configs
rm -f "$HOME/.config/compton.conf"

# xdg configs in ~/.config
mkdir -p ~/.config/
for file in picom.conf; do
    rm -f ~/.config/$file
    ln -s $PWD/$file ~/.config/$file;
done

# i3 is special
rm -f ~/.config/i3/config
mkdir -p ~/.config/i3/
ln -s "$PWD"/i3-config ~/.config/i3/config

# vim tmp dir and plugins
mkdir -p ~/.vim/tmp/
mkdir -p ~/.vim/plugin/
for file in linuxsty.vim qml.vim; do
    rm -f ~/.vim/plugin/$file;
    ln -s $PWD/$file ~/.vim/plugin/$file;
done

# firejail sandboxing config
mkdir -p ~/.config/firejail/
for file in makepkg.local makepkg-nonet.profile; do
    rm -f ~/.config/firejail/"$file";
    ln -s "$PWD/$file" ~/.config/firejail/"$file";
done

# Global keyboard shortcuts
mkdir -p ~/.config/hkd/
rm -f ~/.config/hkd/config
ln -s "$PWD"/hkd-config ~/.config/hkd/config

# Konsole non-config stuff
rm -rf ~/.local/share/kxmlgui5/konsole
ln -s "$PWD/kxmlgui5/konsole" ~/.local/share/kxmlgui5/

rm -rf ~/.local/share/konsole
ln -s "$PWD/konsole" ~/.local/share/


## Setup for stuff

# bash apparently needs us to do this?
touch ~/.bash_history

# Update config in ~/.less from ~/.lesskey
lesskey

# Update X resorce database
xrdb  ~/.Xdefaults

set +ex

# Make sure the necessary not-so-common stuff is installed
for program in hkd firejail stderred picom pastenotifier sandsmark-notificationd unclutter light xss-lock mangonel; do
    which "$program" >/dev/null
done
