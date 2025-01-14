# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="murilasso"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker)

source $ZSH/oh-my-zsh.sh

# unlimited history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

source ~/.profile

for file in ~/.my_scripts/zsh_functions/*; do
  source "$file"
done
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# add pip packages that are installed with --user to path
export PATH=$PATH:~/.local/bin

# add utility script path
export PATH=$PATH:~/.my_scripts

# create GHIDRA_PATH variable used in .my_scripts
export GHIDRA_PATH=/opt/ghidra

# local bin path
export PATH=$PATH:~/bin

# add go binaries to path
command -v go > /dev/null && export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"

# set custom nvim path for using dev version
# export VIMRUNTIME=~/tools/nvim-linux64/share/nvim/runtime/

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# # if tmux is executable, X is running, and not inside a tmux session, then try to attach.
# # if attachment fails, start a new session
# if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ]; then
#   [ -z "${TMUX}" ] && { tmux attach || tmux; } >/dev/null 2>&1
# fi
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT='-c'
export BAT_THEME="Monokai Extended Light"
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

alias python="python3"
alias cdshr="cd /media/sf_readwrite"
alias vim="nvim"

alias vimconfig="pushd ~/.config/nvim; $EDITOR .; popd"
alias cat="bat"
alias sudovim="sudo -E -s nvim"
alias hx="helix"
alias rg="rg --colors 'path:fg:yellow'"
alias sd="systemctl" # systemd
alias ssd="sudo -s -E systemctl" # sudo systemd
alias ls=eza

if [ -z "$WAYLAND_DISPLAY" ]
then
  alias setclip="xclip -selection c"
  alias getclip="xclip -selection c -o"
  alias wmconfig="$EDITOR ~/.config/i3/config"
else
  alias setclip=wl-copy
  alias getclip=wl-paste
  alias wmconfig="$EDITOR ~/.config/sway/config"
fi


export sysd="/etc/systemd/system/"
setopt PUSHDSILENT

grep -q "Microsoft" /proc/sys/kernel/osrelease
ON_WSL=$?
if [ $ON_WSL -eq 0 ]
then
	# on wsl only
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias cdwin='cd /mnt/c/Users/Marius'
	setopt no_beep
	setopt NO_LIST_BEEP
	set bell-style none
else
	# on linux only
fi

# node version manager config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# use ripgrep as default fzf command
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '

[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# customize the **<tab> command
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    # default case needs to be here
    *)            fzf "$@" ;;
  esac
}

