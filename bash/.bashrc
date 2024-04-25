#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/vic/google-cloud-sdk/path.bash.inc' ]; then . '/home/vic/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/vic/google-cloud-sdk/completion.bash.inc' ]; then . '/home/vic/google-cloud-sdk/completion.bash.inc'; fi
