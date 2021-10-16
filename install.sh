#!/bin/sh -e

## Install files

if [[ ! -x ~/src/promptprint/promptprint ]]; then
    echo "fix promptprint"
    exit 1
fi

set -x

# It's a folder, so clean it up manually first
rm -rf ~/.Xresources.d
# Only if it doesn't exist, beceuase xdpyinfo is shit
if [[ ! -f "$PWD/Xresources.d/xft.dpi" ]]; then
    # Hack of the year award, please
    echo "Xft.dpi: $(echo "$(xrandr --listactivemonitors | grep '^ 0:' | cut -d\  -f4 | cut -dx -f1) / 0.0394" | bc)" > "$PWD/Xresources.d/xft.dpi"
fi

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
for file in shortcut-satan.conf picom.conf compton.conf; do
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

# Konsole non-config stuff
rm -rf ~/.local/share/kxmlgui5/konsole
ln -s "$PWD/kxmlgui5/konsole" ~/.local/share/kxmlgui5/

rm -rf ~/.local/share/konsole
ln -s "$PWD/konsole" ~/.local/share/


## Setup for stuff

# bash apparently needs us to do this?
touch ~/.bash_history

# Update X resorce database
xrdb  ~/.Xdefaults

set +ex

# Make sure the necessary not-so-common stuff is installed
for program in launch-konsole shortcut-satan firejail stderred compton pastenotifier sandsmark-notificationd unclutter light xss-lock mangonel qeh; do
    which "$program" >/dev/null
done
