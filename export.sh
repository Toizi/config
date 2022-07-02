#!/usr/bin/env sh
cp .vimrc ~
mkdir -p ~/.config/nvim/
cp .vimrc ~/.config/nvim/init.vim
mkdir -p ~/.config/i3/
rsync -ra ./i3/ ~/.config/i3
mkdir -p ~/.config/i3blocks/
rsync -ra ./i3blocks/ ~/.config/i3blocks
cp .radare2rc ~
cp .Xmodmap ~
cp .xinitrc ~
cp .Xresources ~
cp .dircolors ~
cp .zshrc ~
cp .zprofile ~
cp .bashrc ~
cp .profile ~
cp .tmux.conf ~
rsync -ra ./.my_scripts ~/
mkdir -p ~/.config/terminator
rsync -ra ./terminator/ ~/.config/terminator/
mkdir -p ~/.config/Code/User/
rsync -ra Code/User/ ~/.config/Code/User/

echo "installing vscode extensions"
# ./install_extensions.py

