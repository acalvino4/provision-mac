# Install xcode command line tools; required for homebrew, xcode, and maybe some other applications
source "$ROCK_DIR"/lib/xcode.sh

source "$ROCK_DIR"/lib/homebrew.sh

source "$ROCK_DIR"/lib/brew-followup.sh

# Additional ddev setup
mkcert -install

# Link tableplus config
# (Once/if they support it)

# Merge vscode settings with user's, if they exist
VSCODE_SETTINGS="$ROCK_DIR"/config/.vscode/settings.json
VSCODE_USER_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
if [[ -f $VSCODE_USER_SETTINGS ]]; then
    jq -s '.[0] * .[1]' "$VSCODE_SETTINGS" "$VSCODE_USER_SETTINGS" >/tmp/vscode_settings
    sudo cp /tmp/vscode_settings "$VSCODE_USER_SETTINGS"
else
    sudo mkdir -p "$(dirname "$VSCODE_USER_SETTINGS")"
    sudo cp "$VSCODE_SETTINGS" "$VSCODE_USER_SETTINGS"
fi
# Install vscode extensions
while IFS= read -r LINE; do
    code --install-extension "$LINE"
done <"$ROCK_DIR"/config/.vscode/extensions.txt

# Setup oh-my-zsh & its plugins
source "$ROCK_DIR"/lib/oh-my-zsh.sh

# Setup vim & its plugins
source "$ROCK_DIR"/lib/vim-plug.sh

echo "Ensuring updatedb is on PATH"
if [[ ! -f /usr/local/bin/updatedb ]]; then
    ln -s /usr/libexec/locate.updatedb /usr/local/bin/updatedb
fi

echo "Aliasing 'python' to 'python3'"
if [[ ! -f /usr/local/bin/python ]]; then
    ln -s /usr/local/bin/python3 /usr/local/bin/python
fi

echo "Ensuring rock is on PATH..."
if [[ ! -f /usr/local/bin/rock ]]; then
    ln -s "$ROCK_DIR"/rock /usr/local/bin/rock
fi

read -rp "Would you like to reboot (y/n)? " REBOOT
if [[ $REBOOT =~ ^[Yy] ]]; then
    reboot
fi
