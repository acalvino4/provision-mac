# Install homebrew
if [[ $(command -v brew) == "" ]]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "✓ Homebrew installed successfully"
else
    echo "✓ Homebrew already installed"
fi

brew_install() {
    local pkg=${*: -1}
    if echo "$BREW_INSTALLED_PACKAGES" | grep -q "^${pkg}$"; then
        echo "  ✓ $pkg already installed"
    else
        echo "  Installing $pkg..."
        if brew install "$@" >/dev/null; then
            echo "  ✓ $pkg installed successfully"
            # Add to cached list
            BREW_INSTALLED_PACKAGES="${BREW_INSTALLED_PACKAGES}${pkg}"$'\n'
        else
            echo "  ⚠️  Failed to install $pkg"
            return 1
        fi
    fi
}

# Install desired brew packages
if [[ $SUBCOMMAND != "install" ]]; then # if stdin is a terminal
    read -rp "Would you like to install/update/upgrade homebrew packages (y/n)? " UPGRADE
else
    UPGRADE=y
fi
if [[ $UPGRADE =~ ^[Yy] ]]; then
    echo "Updating Homebrew..."
    brew update

    # Cache installed packages list once
    echo "Checking installed packages..."
    BREW_INSTALLED_PACKAGES=$(brew list --formula && brew list --cask)

    echo ""
    echo "Installing Applications..."
    # Applications
    # brew_install --cask slack     # Team communication
    brew_install --cask gimp     # Powerful, free image editing
    brew_install --cask inkscape # SVG editor
    brew_install --cask figma    # For viewing desings (or making them - I ain't stopping you)
    brew_install --cask bitwarden

    echo ""
    echo "Installing Local Development Tools..."
    # Local development
    brew_install --cask visual-studio-code # Your bread and butter
    brew_install --cask zed                # A next-gen editor
    brew_install --cask android-studio     # Necessary for android apps
    brew_install --cask tableplus          # Friendly RDBMS GUI
    # brew_install --cask docker             # Containers, containers, containers...
    brew_install --cask local              # Wordpress
    brew_install ddev/ddev/ddev            # Craft

    echo ""
    echo "Installing Browsers..."
    # Browsers (for cross-browser testing)
    brew_install --cask brave-browser
    brew_install --cask microsoft-edge
    brew_install --cask firefox
    # brew_install --cask google-chrome
    brew_install --cask browserstacklocal

    echo ""
    echo "Installing Version/Package Managers..."
    # Version/Package Managers
    brew_install composer # php dependencies
    brew_install uv       # python project manager
    brew_install rbenv    # ruby versions

    echo ""
    echo "Installing Runtimes..."
    # Runtimes
    brew_install node   # js runtime
    brew_install deno   # js runtime
    brew_install php    # php runtime
    brew_install python # python runtime

    echo ""
    echo "Installing Misc. Tools..."
    # Misc. Tools
    brew_install htop       # Colorized system monitoring
    brew_install wget       # An alternative to curl
    brew_install jq         # For parsing and editing json from command line
    brew_install bash       # Because macOS ships with a very out of date version
    brew_install shellcheck # A linter for shell scripts
    brew_install shfmt      # A formatter for shell scripts

    echo ""
    echo "Installing Dependencies..."
    # Dependencies
    brew_install readline   # rbenv
    brew_install libyaml    # ruby
    brew_install gmp        # ruby
    brew_install openssl@3  # ruby
    brew_install ruby-build # ruby
    brew_install nss        # mkcert

    echo ""
    echo "Upgrading existing packages..."
    brew upgrade
    echo "✓ Homebrew packages updated"

    # Install last 3 dotnet LTS versions
    echo ""
    echo "Installing .NET LTS SDKs..."
    if ! brew tap | grep -q "isen-ng/dotnet-sdk-versions"; then
        echo "  Adding dotnet-sdk-versions tap..."
        brew tap isen-ng/dotnet-sdk-versions >/dev/null
    fi

    # Get the latest 3 LTS major versions (even numbers only)
    LTS_MAJORS=$(brew search dotnet-sdk | grep -oE 'dotnet-sdk[0-9]+$' | grep -oE '[0-9]+$' | awk '$1 % 2 == 0' | sort -u -n | tail -3)

    # Install each LTS version (latest patch auto-selected)
    while read -r major; do
        [[ -z "$major" ]] && continue
        brew_install --cask "dotnet-sdk${major}"
    done <<< "$LTS_MAJORS"

    echo "✓ .NET LTS SDKs installed"
fi
