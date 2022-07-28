rsync -ra ~/.config/nvim . --exclude plugin/
cp -r ~/.config/i3 .
cp -r ~/.config/i3blocks .
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
cp ~/.config/alacritty/alacritty.yml ./.alacritty
cp -r ~/.my_scripts .
cp ~/.config/Code/User/keybindings.json ~/.config/Code/User/settings.json ./Code/User/
code --list-extensions > vscode_extensions.txt

