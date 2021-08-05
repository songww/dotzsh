# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/lib/cargo/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH:/usr/local/sbin

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

export PYENV_VIRTUALENV_DISABLE_PROMPT=0

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle rust
#antigen bundle pyenv
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

antigen bundle IngoMeyer441/zsh-easy-motion
antigen bundle wfxr/forgit

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

alias enable_proxy='export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;'
alias disable_proxy='unset http_proxy; unset https_proxy';

#export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

fpath=(/usr/local/share/zsh-completions $fpath)

# rust
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static

# flutter
export FLUTTER_STORAGE_BASE_URL="https://mirrors.tuna.tsinghua.edu.cn/flutter"

# Pub 是 Dart 官方的包管理器。跨平台的前端应开发 框架 Flutter 也基于 Dart 并且可以使用大部分 Pub 中的 库。
export PUB_HOSTED_URL="https://mirrors.tuna.tsinghua.edu.cn/dart-pub/"

update-rust-analyzer () {
    set -e
    if [[ "$(uname)" == "Linux" ]]; then
        target=rust-analyzer-x86_64-unknown-linux-gnu
        mybesudo=sudo
        aria2c -c --optimize-concurrent-downloads -j 16 -s16 -x16 -k1M \
            --download-result=hide --log-level=error --console-log-level=error --file-allocation=none \
            https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-x86_64-unknown-linux-gnu.gz \
            --all-proxy=http://127.0.0.1:1087 \
            -o $target.gz \
            -d /tmp
    elif [[ "$(uname)" == "Darwin" ]]; then
        target=rust-analyzer-x86_64-apple-darwin
        mybesudo=
        aria2c -c --optimize-concurrent-downloads -j 16 -s16 -x16 -k1M \
            --download-result=hide --log-level=error --console-log-level=error --file-allocation=none \
            --all-proxy=http://127.0.0.1:1087 \
            https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-x86_64-apple-darwin.gz \
            -o $target.gz \
            -d /tmp
    fi
    echo ""
    gunzip -fd /tmp/$target.gz
    $mybesudo mv /tmp/$target /usr/local/bin/rust-analyzer
    $mybesudo chmod +x /usr/local/bin/rust-analyzer
    set +e +o pipefail
}

export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_NDK_ROOT=$ANDROID_SDK_ROOT/ndk/21.4.7075529

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH

function check_command_exists {
    which $1 &>/dev/null
}

if [[ `uname` == 'Darwin' ]]; then
    check_command_exists zoxide
    if [[ $? != 0 ]]; then
        brew install zoxide
    fi
    check_command_exists exa; if [[ $? != 0 ]]; then
        brew install exa
        EXA_EXISTS=0
    else
        EXA_EXISTS=1
    fi
    check_command_exists fzf; if [[ $? != 0 ]]; then
        brew install fzf
    fi
    check_command_exists htop; if [[ $? != 0 ]]; then
        brew install htop
    fi
elif [[ $(uname) == 'Linux' ]]; then
    check_command_exists zoxide; if [[ $? != 0 ]]; then
        echo please install `zoxide`
    fi
    check_command_exists exa; if [[ $? != 0 ]]; then
        echo please install `exa`
        EXA_EXISTS=0
    else
        EXA_EXISTS=1
    fi
    check_command_exists fzf; if [[ $? != 0 ]]; then
        echo please install `fzf`
    fi
    check_command_exists htop; if [[ $? != 0 ]]; then
        echo please install `htop`
    fi
fi

if [[ $EXA_EXISTS == 1 ]]; then
    # general use
    alias ls='exa'                                                          # ls
    alias l='exa -lbF --git'                                                # list, size, type, git
    alias ll='exa -lbGF --git'                                             # long list
    alias llm='exa -lbGd --git --sort=modified'                            # long list, modified date sort
    alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale'  # all list
    alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list

    # specialty views
    alias lS='exa -1'                                                              # one column, just names
    alias lt='exa --tree --level=2'                                         # tree
fi

eval "$(zoxide init zsh)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
