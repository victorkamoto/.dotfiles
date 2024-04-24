# Vars
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

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000000
HIST_IGNORE_ALL_DUPS=1
HIST_FIND_NO_DUPS=1
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vic/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# AutoSuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# HSTR configuration - add this to ~/.zshrc
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)
export HSTR_TIOCSTI=y

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
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
# <<< conda initialize <<<

# bun completions
[ -s "/home/vic/.bun/_bun" ] && source "/home/vic/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
source /usr/share/nvm/init-nvm.sh

# Node Version Manager
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec

# pnpm
export PNPM_HOME="/home/vic/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# mkdir && cd helper
function mkcd {
        if [ ! -n "$1" ]; then
                echo "Enter a directory name"
        elif [ -d "$1" ]; then
                echo "\$1 already exists"
        else
                mkdir -p $1 && cd $1
        fi
}

# Alias for nvim
alias vim=nvim

# Alias for fzf-man
alias fman='compgen -c | fzf | xargs man'

# Alias for fzf-tldr
alias ftldr='compgen -c | fzf | xargs tldr'

# Alias for kickstart
alias vim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# Starship prompt
eval "$(starship init zsh)"

