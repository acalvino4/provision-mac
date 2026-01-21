export VIM_DIR=~/.vim
vim -E -s -u "$ROCK_DIR/config/vimrc" +PlugUpdate +PlugClean! +qall
