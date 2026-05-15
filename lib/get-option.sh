CONFIG_FILE=~/.rock.json

get_rock_option() {
    local option choice
    option=$1

    if [[ ! $SUBCOMMAND == 'install' && -f $CONFIG_FILE ]]; then
        CONFIG_CLEAN=$(json_strip_trailing_commas "$CONFIG_FILE")
        choice=$(jq '."$option"' "$CONFIG_CLEAN")
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
    CONFIG_CLEAN=$(json_strip_trailing_commas "$CONFIG_FILE")
    jq '."$option"'='"$choice"' "$CONFIG_CLEAN" >"$CONFIG_FILE"
    echo $choice
}
