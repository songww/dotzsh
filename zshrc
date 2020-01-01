# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:$PATH

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

if [ -f /usr/share/zsh-antigen/antigen.zsh ]; then
    # sudo apt install antigen
    source /usr/share/zsh-antigen/antigen.zsh
elif [ -f /usr/local/share/antigen/antigen.zsh ]; then
    # brew install antigen
    source /usr/local/share/antigen/antigen.zsh
fi

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle rust
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
antigen theme iplaces/astro-zsh-theme astro

antigen apply

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias vihosts='sudo vim /etc/hosts'

if [[ `uname` == 'Darwin' ]]; then
    alias vim=nvim

    # mysql-client is keg-only, which means it was not symlinked into /usr/local,
    # because conflicts with mysql.
    # If you need to have mysql-client first in your PATH run:
    export PATH="/Users/songww/.composer/vendor/bin:/usr/local/opt/mysql-client/bin:$PATH"

    # For compilers to find mysql-client you may need to set:
    export LDFLAGS=$LDFLAGS" -L/usr/local/opt/mysql-client/lib"
    export CPPFLAGS=$CPPFLAGS" -I/usr/local/opt/mysql-client/include -I/usr/local/opt/openssl/include"

    # For pkg-config to find mysql-client you may need to set:
    export PKG_CONFIG_PATH="/usr/local/opt/mysql-client/lib/pkgconfig"
elif [[ $(uname) == 'Linux' ]]; then
    echo Linux
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

fpath=(/usr/local/share/zsh-completions $fpath)

# rust
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

# flutter
export FLUTTER_STORAGE_BASE_URL="https://mirrors.tuna.tsinghua.edu.cn/flutter"

# Pub 是 Dart 官方的包管理器。跨平台的前端应开发 框架 Flutter 也基于 Dart 并且可以使用大部分 Pub 中的 库。
export PUB_HOSTED_URL="https://mirrors.tuna.tsinghua.edu.cn/dart-pub/"
