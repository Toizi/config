#!/usr/bin/env sh
mkdir -p ~/.config/nvim/
rsync -ra ./nvim/ ~/.config/nvim
mkdir -p ~/.config/lvim/
rsync -ra ./lvim/ ~/.config/lvim
mkdir -p ~/.config/sway/
rsync -ra ./sway/ ~/.config/sway
mkdir -p ~/.config/waybar/
rsync -ra ./waybar/ ~/.config/waybar
mkdir -p ~/.config/swaylock/
rsync -ra ./swaylock/ ~/.config/swaylock
mkdir -p ~/.config/gammastep/
rsync -ra ./gammastep/ ~/.config/gammastep
mkdir -p ~/.config/i3/
rsync -ra ./i3/ ~/.config/i3
mkdir -p ~/.config/i3blocks/
rsync -ra ./i3blocks/ ~/.config/i3blocks
mkdir -p ~/.config/redshift
rsync -ra ./redshift/ ~/.config/redshift
mkdir -p ~/.config/picom
cp picom.conf ~/.config/picom/
mkdir -p ~/.config/helix
cp helix.toml ~/.config/helix/config.toml
cp .radare2rc ~
mkdir -p ~/.config/git
cp .gitconfig ~/.config/git/config
cp .Xmodmap ~
cp .xinitrc ~
cp .Xresources ~
cp .dircolors ~
cp .zshrc ~
cp .zprofile ~
cp .bashrc ~
cp .profile ~
cp .tmux.conf ~

# resticprofile can be user-readable, only the config.toml must be root:root
sudo mkdir -p /etc/resticprofile/shared
sudo chown "$USER:$USER" /etc/resticprofile /etc/resticprofile/shared
rsync -ra ./resticprofile_shared/ /etc/resticprofile/shared/

# some scripts should be made available globally for use with systemd or other
# root processes
rsync -ra ./.my_scripts ~/
sudo ln -s ~/.my_scripts/systemd-notify-failure /usr/local/bin
sudo ln -s ~/.my_scripts/root-notify-send /usr/local/bin

mkdir -p ~/.config/terminator
rsync -ra ./terminator/ ~/.config/terminator/
mkdir -p ~/.config/alacritty/
cp alacritty.yml ~/.config/alacritty/alacritty.yml
mkdir -p ~/.config/Code/User/
rsync -ra Code/User/ ~/.config/Code/User/

# echo "installing vscode extensions"
# ./install_extensions.py

