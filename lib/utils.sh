#!/usr/bin/env bash

# Strip trailing commas from JSON file and return path to cleaned temp file
# Usage: cleaned=$(json_strip_trailing_commas "$file")
json_strip_trailing_commas() {
    local input_file="$1"
    local temp_file="/tmp/rock_json_clean_$$.json"

    if [[ ! -f "$input_file" ]]; then
        echo "$input_file"
        return 1
    fi

    # Use perl to strip trailing commas before closing braces/brackets
    perl -0pe 's/,(\s*[}\]])/\1/g' "$input_file" >"$temp_file"
    echo "$temp_file"
}
