cp ~/.config/nvim/init.vim .vimrc
cp ~/.radare2rc .
cp ~/.Xmodmap .
cp ~/.dircolors .
cp ~/.zshrc .
cp ~/.bashrc .
cp ~/.tmux.conf .
cp -r ~/.config/terminator .
cp -r ~/.my_scripts .
cp ~/.config/Code/User/keybindings.json ~/.config/Code/User/settings.json ./Code/User/
code --list-extensions > vscode_extensions.txt

