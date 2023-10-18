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
