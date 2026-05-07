#!/usr/bin/env bash
rsync -ra ~/.config/nvim . --exclude plugin/
cp -r ~/.config/sway .
cp -r ~/.config/swaylock .
cp -r ~/.config/waybar .
cp -r ~/.config/gammastep .
cp -r ~/.config/swappy .
cp ~/.config/git/config .gitconfig
cp ~/.Xmodmap .
cp ~/.xinitrc .
cp ~/.Xresources .
cp ~/.dircolors .
cp ~/.zshrc .
cp ~/.zprofile .
cp ~/.bashrc .
cp ~/.profile .
cp ~/.tmux.conf .
rsync -ra /etc/resticprofile/shared/ ./resticprofile_shared
cp /etc/keyd/default.conf ./keyd.conf
cp -r ~/.config/terminator .
cp ~/.config/alacritty/alacritty.toml ./alacritty.toml
cp ~/.config/helix/config.toml helix.toml
cp ~/.config/systemd/user/sway-session.target .
rsync -ra ~/.my_scripts .
cp ~/.config/Code/User/keybindings.json ~/.config/Code/User/settings.json ./Code/User/
# code --list-extensions > vscode_extensions.txt

