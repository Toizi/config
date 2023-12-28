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
mkdir -p ~/.config/swappy
rsync -ra ./swappy/ ~/.config/swappy
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
cp ./sway-session.target ~/.config/systemd/user/

# resticprofile can be user-readable, only the config.toml must be root:root
if [[ ! -d "/etc/resticprofile/shared" ]]; then
  sudo mkdir -p /etc/resticprofile/shared
  sudo chown "$USER:$USER" /etc/resticprofile /etc/resticprofile/shared
fi
rsync -ra ./resticprofile_shared/ /etc/resticprofile/shared/

if [[ ! -d "/etc/keyd" || $(stat -c "%U" "/etc/keyd") != "$USER" ]]; then
  sudo mkdir -p /etc/keyd/
  sudo chown "$USER:$USER" /etc/keyd
fi
cp ./keyd.conf /etc/keyd/default.conf

# some scripts should be made available globally for use with systemd or other
# root processes
rsync -ra ./.my_scripts ~/
for SCRIPT in systemd-notify-failure root-notify-send systemd-gotify-failure gotify-send
do
  if [[ ! -f "/usr/local/bin/${SCRIPT}" ]]; then
    sudo ln -s "$HOME/.my_scripts/${SCRIPT}" /usr/local/bin
  fi
done

# setup secrets directory in case it does not exist
if [[ -d "/data" && ! -d "/data/secrets" ]]; then
  echo "created /data/secrets/, make sure to populate secrets as needed"
  sudo mkdir -p /data/secrets
fi

mkdir -p ~/.config/terminator
rsync -ra ./terminator/ ~/.config/terminator/
mkdir -p ~/.config/alacritty/
cp alacritty.toml ~/.config/alacritty/alacritty.toml
mkdir -p ~/.config/Code/User/
rsync -ra Code/User/ ~/.config/Code/User/

# echo "installing vscode extensions"
# ./install_extensions.py

