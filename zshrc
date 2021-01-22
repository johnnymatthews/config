# DEFAULT ZSH SETTINGS
# --------------------
# Path to your oh-my-zsh installation.
export ZSH="/home/johnny/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
export PATH=$PATH:/usr/local/go/bin
# --------------------


# ALIASES
# -------
alias t="todo.sh -d ~/.config/todo/config"
alias ytdl="cd ~/Downloads && youtube-dl -x --audio-format mp3"
alias t-sync="cd ~/.config/todo && git pull && git add . && git commit -m 'Updates' && git push"
# -------


# UTILITY FUNCTIONS
# -----------------
# Copy contents of file to clipboard.
function copy() {
    cat $1 | xclip -i -selection clipboard
}

# VPN CONNECTIONS
function vpn_connect() {
    echo $1
}

# OPEN FILE BROWSER
function open_dir() {
    nautilus $1 & 
}
# -----------------


# VIM MODE CONFIG 
# ---------------
bindkey -v                              # Active Vim mode.
KEYTIMEOUT=5                            # Remove mode switching delay.

function zle-keymap-select {            # Change cursor shape.
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

echo -ne '\e[5 q'                       # Use beam shape cursor on startup.
preexec() {                             # Use beam shape cursor for each new prompt.
   echo -ne '\e[5 q'
}
# ---------------

