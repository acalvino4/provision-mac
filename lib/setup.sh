# Install xcode command line tools; required for homebrew, xcode, and maybe some other applications
xcode-select --install

source "$ROCK_DIR"/lib/homebrew.sh

source "$ROCK_DIR"/lib/brew-followup.sh

# Additional ddev setup
mkcert -install

# Link tableplug config

# Merge vscode settings with user's
VSCODE_SETTINGS=/Library/"Application Support"/Code/User/settings.json
jq -s '.[0] * .[1]' "$ROCK_DIR"/config/.vscode/settings.json "$VSCODE_SETTINGS" >/tmp/vscode_settings
mv /tmp/vscode_settings "$VSCODE_SETTINGS"
# Install vscode extensions
while IFS= read -r LINE; do
    code --install-extension "$LINE"
done <"ROCK_DIR"/.vscode/extensions.txt

# Setup oh-my-zsh & its plugins
source "$ROCK_DIR"/lib/oh-my-zsh.sh

# Setup vim & its plugins
source "$ROCK_DIR"/lib/vim-plug.sh

# Link vim config
INSTALL_VIMRC=$(get_option vimrc)
if $INSTALL_VIMRC; then
    sed -i '' "1s-^-let \$VIM_DIR='$VIM_DIR' \" Managed by rock\n-g" ~/.vimrc
    sed -i '' "2s-^-source $ROCK_DIR/config/vimrc \" Managed by rock\n-g" ~/.vimrc
    sed -i '' "3s-^-\" Include your own configurations below this line \" Managed by rock\n-g" ~/.vimrc
fi

echo "Linking vim config..."
ln -f "$ROCK_DIR"/config/vimrc /etc/vim/vimrc.local

echo "Ensuring updatedb is on PATH"
ln -s /usr/libexec/locate.updatedb /usr/local/bin/updatedb

echo "Ensuring rock is on PATH..."
if [[ ! -f /usr/local/bin/rock ]]; then
    ln -s "$ROCK_DIR"/rock /usr/local/bin/rock
fi

read -rp "Would you like to reboot (y/n)? " REBOOT
if [[ $REBOOT =~ ^[Yy] ]]; then
    reboot
fi
