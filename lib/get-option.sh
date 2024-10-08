CONFIG_FILE=~/.rock.json

get_option() {
    local option choice
    option=$1

    if [[ ! $SUBCOMMAND == 'install' && -f $CONFIG_FILE ]]; then
        choice=$(jq '.'"$option"'' $CONFIG_FILE)
        if [[ $choice != null ]]; then
            echo "$choice" && return
        fi
    fi
    if [[ ! -f $CONFIG_FILE ]]; then
        echo "{}" >>$CONFIG_FILE
    fi
    read -rp "Would you like rock to install it's $option (y/n)? " choice
    if [[ $choice =~ ^[Yy] ]]; then
        choice=true
    else
        choice=false
    fi
    # shellcheck disable=2094
    cat <<<"$(jq '.'"$option"'='"$choice"'' $CONFIG_FILE)" >$CONFIG_FILE
    echo $choice
}
