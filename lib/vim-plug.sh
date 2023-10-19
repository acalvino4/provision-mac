VIM_DIR=~/.vim

if [[ ! -f $VIM_DIR/autoload/plug.vim ]]; then
    echo "Installing Vim Plug..."
    curl -fLo "$VIM_DIR"/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    chmod -R o+rx "$VIM_DIR"/autoload
fi

echo "Installing Vim Plugins..."
export VIM_DIR
set +e
vim -E -s -u "$ROCK_DIR/config/vimrc" +PlugInstall +qall
set -e

# Link vim config
INSTALL_VIMRC=$(get_option vimrc)
if $INSTALL_VIMRC; then
    printf '\n' >>~/.vimrc
    sed -i '' "1s-^-let \$VIM_DIR='$VIM_DIR' \" Managed by rock\n-g" ~/.vimrc
    sed -i '' "2s-^-source $ROCK_DIR/config/vimrc \" Managed by rock\n-g" ~/.vimrc
    sed -i '' "3s-^-\" Include your own configurations below this line \" Managed by rock\n-g" ~/.vimrc
fi
