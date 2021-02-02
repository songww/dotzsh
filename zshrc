# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$PATH

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

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle rust
antigen bundle pyenv
antigen bundle docker
antigen bundle debian
antigen bundle poetry
antigen bundle python
antigen bundle vscode
antigen bundle colorize
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle zsh-users/zsh-autosuggestions

antigen bundle zsh-users/zsh-completions

# Load the theme.
antigen theme iplaces/astro-zsh-theme astro

antigen bundle skywind3000/z.lua

antigen apply

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias vihosts='sudo vim /etc/hosts'
alias top=htop

alias zc='z -c'      # 严格匹配当前路径的子路径
alias zz='z -i'      # 使用交互式选择模式
alias zf='z -I'      # 使用 fzf 对多个结果进行选择
alias zb='z -b'      # 快速回到父目录

alias enable_proxy='export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;'
alias disable_proxy='unset http_proxy; unset https_proxy';


export PATH=/opt/nvim-osx64/bin:$PATH
alias vim=nvim

if [[ `uname` == 'Darwin' ]]; then
    export PKG_CONFIG_PATH="/usr/local/opt/mysql-client/lib/pkgconfig"
elif [[ $(uname) == 'Linux' ]]; then
    echo Linux
fi

export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles

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

update-rust-analyzer () {
    cd /usr/local/bin
    https_proxy=http://127.0.0.1:1087 aria2c -c --optimize-concurrent-downloads -j 16 -s16 -x16 -k1M \
        https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-mac \
        -o rust-analyzer
    chmod +x /usr/local/bin/rust-analyzer
    cd -
}

export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_NDK_ROOT=$ANDROID_SDK_ROOT/ndk/22.0.7026061

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
