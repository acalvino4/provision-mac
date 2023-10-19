ZSHRC=~/.zshrc

# pnpm
if ! grep -Fq pnpm $ZSHRC; then
    # Setup pnpm
    pnpm setup
    export PNPM_HOME=~/Library/pnpm
    export PATH="$PNPM_HOME:$PATH"
    pnpm env use -g lts
fi

# pyenv
# shellcheck disable=2016
pyenv='# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PYTHON_CONFIGURE_OPTS="--enable-shared" # For pyinstaller to work
# end pyenv
'
if ! grep -Fq pyenv "$ZSHRC"; then
    echo "$pyenv" >>"$ZSHRC"
fi

# rbenv
# shellcheck disable=2016
rbenv='# rbenv
eval "$(rbenv init - zsh)"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"
# end rbenv
'
if ! grep -Fq rbenv "$ZSHRC"; then
    echo "$rbenv" >>"$ZSHRC"
fi

# pdm
# shellcheck disable=2016
pdm='# pdm
# enable pep582 support
eval "$(pdm --pep582)"
# end pdm
'
if ! grep -Fq pdm $ZSHRC; then
    echo "$pdm" >>$ZSHRC
    pdm plugin add pdm-vscode
    pdm config install.cache on
    pdm config strategy.save compatible
    pdm config python.use_venv False
    # enable pdm shell completion
    mkdir ~/.oh-my-zsh/custom/plugins/pdm
    pdm completion zsh >~/.oh-my-zsh/custom/plugins/pdm/_pdm
fi

# sdkman
if ! grep -Fq sdkman $ZSHRC; then
    echo "Installing sdkman to manage jvm languages..."
    curl -s "https://get.sdkman.io" | bash
    set +u
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    set -u
fi
