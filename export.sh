#!/usr/bin/env sh
cp .vimrc ~
mkdir -p ~/.config/nvim/
cp .vimrc ~/.config/nvim/init.vim
cp .radare2rc ~
cp .Xmodmap ~
cp .dircolors ~
cp .zshrc ~
cp .bashrc ~
cp .tmux.conf ~
cp -r .my_scripts ~/
mkdir -p ~/.config/terminator
cp terminator/* ~/.config/terminator/
mkdir -p ~/.config/Code/User/
cp Code/User/* ~/.config/Code/User/

echo "installing vscode extensions"
./install_extensions.py

