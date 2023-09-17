rsync -ra ~/.config/nvim . --exclude plugin/
rsync -ra ~/.config/lvim . --exclude plugin/ --exclude lazy-lock.json --exclude ignore
cp -r ~/.config/sway .
cp -r ~/.config/swaylock .
cp -r ~/.config/waybar .
cp -r ~/.config/gammastep .
cp -r ~/.config/i3 .
cp -r ~/.config/i3blocks .
cp -r ~/.config/redshift .
cp ~/.config/picom/picom.conf .
cp ~/.radare2rc .
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
cp /etc/evremap.toml .
cp -r ~/.config/terminator .
cp ~/.config/alacritty/alacritty.yml ./alacritty.yml
cp ~/.config/helix/config.toml helix.toml
cp -r ~/.my_scripts .
cp ~/.config/Code/User/keybindings.json ~/.config/Code/User/settings.json ./Code/User/
# code --list-extensions > vscode_extensions.txt

