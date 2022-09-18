rsync -ra ~/.config/nvim . --exclude plugin/
rsync -ra ~/.config/lvim . --exclude plugin/
cp -r ~/.config/i3 .
cp -r ~/.config/i3blocks .
cp -r ~/.config/redshift .
cp ~/.config/picom/picom.conf .
cp ~/.radare2rc .
cp ~/.Xmodmap .
cp ~/.xinitrc .
cp ~/.Xresources .
cp ~/.dircolors .
cp ~/.zshrc .
cp ~/.zprofile .
cp ~/.bashrc .
cp ~/.profile .
cp ~/.tmux.conf .
cp -r ~/.config/terminator .
cp ~/.config/alacritty/alacritty.yml ./alacritty.yml
cp ~/.config/helix/config.toml helix.toml
cp -r ~/.my_scripts .
cp ~/.config/Code/User/keybindings.json ~/.config/Code/User/settings.json ./Code/User/
# code --list-extensions > vscode_extensions.txt

