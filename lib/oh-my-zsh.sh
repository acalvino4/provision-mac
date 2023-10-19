OMZ_DIR=~/.oh-my-zsh

if [[ ! -d $OMZ_DIR ]]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    mv ~/.oh-my-zsh "$OMZ_DIR"
    sed -i "/export ZSH=/c\export ZSH=$OMZ_DIR" ~/.zshrc
    INSTALL_ZSH_THEME=$(get_option zsh_theme)
    if $INSTALL_ZSH_THEME; then
        echo 'exit' | /bin/zsh -i -c "omz theme set dpoggi"
    fi
else
    echo "Updating Oh My Zsh..."
    echo 'exit' | /bin/zsh -i -c "omz update &>/dev/null"
fi

/bin/zsh -i -c "omz plugin enable brew git &>/dev/null" || echo
