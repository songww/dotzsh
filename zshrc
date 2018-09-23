# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

if -f /usr/share/zsh-antigen/antigen.zsh; then
    # sudo apt install antigen
    source /usr/share/zsh-antigen/antigen.zsh
elif -f /usr/local/share/antigen/antigen.zsh; then
    # brew install antigen
    source /usr/local/share/antigen/antigen.zsh
fi

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle pyenv
antigen bundle docker
antigen bundle debian
antigen bundle poetry
antigen bundle python
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle zsh-users/zsh-autosuggestions

antigen bundle zsh-users/zsh-completions

# Load the theme.
antigen theme ys

antigen apply

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PIPENV_VENV_IN_PROJECT=1

eval "$(pipenv --completion)"

alias vihosts='sudo vim /etc/hosts'

# eval "$(direnv hook zsh)"
#
export PATH="/home/songww/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
