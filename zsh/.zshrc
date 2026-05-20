export JAVA_HOME=/usr/lib/jvm/default
export NODE_ENV=development
export CHROME_EXECUTABLE=/opt/google/chrome/chrome
export PATH=/home/vic/.cargo/bin:$PATH
export PATH=~/.dotnet/tools:$PATH
export PATH=~/go/bin:$PATH
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY

bindkey -e
zstyle :compinstall filename '/home/vic/.zshrc'

autoload -Uz compinit
compinit

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

__conda_setup="$('/opt/anaconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup

function mkcd {
        if [ ! -n "$1" ]; then
                echo "Enter a directory name"
        elif [ -d "$1" ]; then
                echo "\$1 already exists"
        else
                mkdir -p $1 && cd $1
        fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

function nvm() {
  unfunction nvm
  \. "$NVM_DIR/nvm.sh"
  nvm "$@"
  if [[ "$1" == "use" || "$1" == "install" ]]; then
    corepack enable 2>/dev/null
  fi
}

alias vim=nvim

alias fman='compgen -c | fzf | xargs man'
alias ftldr='compgen -c | fzf | xargs tldr'
export BAT_THEME=gruvbox-dark
alias ls="eza --color=always --git --icons=always"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
source ~/fzf-git.sh/fzf-git.sh
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

alias drop-caches='sudo paccache -rk3; yay -Sc --aur --noconfirm'
alias update-all='export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist \
      && drop-caches \
      && yay -Syyu --noconfirm'

eval "$(fzf --zsh)"

eval "$(zoxide init zsh)"
alias cd="z"

if [ -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt ]; then
    cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
fi

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
export PATH=/home/vic/.opencode/bin:$PATH

eval "$(starship init zsh)"
