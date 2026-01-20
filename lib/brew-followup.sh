ZSHRC=~/.zshrc

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

# sdkman
if ! grep -Fq sdkman $ZSHRC; then
    echo "Installing sdkman to manage jvm languages..."
    curl -s "https://get.sdkman.io" | bash
    set +u
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    set -u
fi

# prioritize /opt/homebrew/bin on PATH
# shellcheck disable=SC2016
homebrew_path='# homebrew hoist
export PATH="${PATH//\/opt\/homebrew\/bin:/}"
export PATH="/opt/homebrew/bin:$PATH"
# end homebrew hoist
'
if ! grep -Fq "# homebrew hoist" "$ZSHRC"; then
    echo "$homebrew_path" >>"$ZSHRC"
fi
