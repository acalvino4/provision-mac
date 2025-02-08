# Install homebrew
if [[ $(command -v brew) == "" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew_install() {
    local pkg=${*: -1}
    echo "Installing $pkg"
    if brew list "$@"; then
        echo "$pkg is already installed"
    else
        brew install "$@" && echo "$pkg is installed"
    fi
}

# Install desired brew packages
if [[ $SUBCOMMAND != "install" ]]; then # if stdin is a terminal
    read -rp "Would you like to install/update/upgrade homebrew packages (y/n)? " UPGRADE
else
    UPGRADE=y
fi
if [[ $UPGRADE =~ ^[Yy] ]]; then
    brew update

    # Applications
    # brew_install --cask slack     # Team communication
    brew_install --cask gimp     # Powerful, free image editing
    brew_install --cask inkscape # SVG editor
    brew_install --cask figma    # For viewing desings (or making them - I ain't stopping you)
    # Local development
    brew_install --cask visual-studio-code # Your bread and butter
    brew_install --cask zed                # A next-gen editor
    brew_install --cask android-studio     # Necessary for android apps
    brew_install --cask tableplus          # Friendly RDBMS GUI
    brew_install --cask docker             # Containers, containers, containers...
    brew_install --cask local              # Wordpress
    brew_install drud/ddev/ddev            # Craft

    # Browsers (for cross-browser testing)
    brew_install --cask brave-browser
    brew_install --cask microsoft-edge
    brew_install --cask firefox
    # brew_install --cask google-chrome
    brew_install --cask browserstacklocal
    # Version/Package Managers
    brew_install composer # php dependencies
    brew_install uv       # python project manager
    brew_install rbenv    # ruby versions
    # Runtimes
    brew_install node   # js runtime
    brew_install deno   # js runtime
    brew_install php    # php runtime
    brew_install python # python runtime
    # Misc. Tools
    brew_install htop       # Colorized system monitoring
    brew_install wget       # An alternative to curl
    brew_install jq         # For parsing and editing json from command line
    brew_install bash       # Because macOS ships with a very out of date version
    brew_install shellcheck # A linter for shell scripts
    brew_install shfmt      # A formatter for shell scripts
    # Dependencies
    brew_install readline   # rbenv
    brew_install libyaml    # ruby
    brew_install gmp        # ruby
    brew_install openssl@3  # ruby
    brew_install ruby-build # ruby
    brew_install nss        # mkcert

    brew upgrade
fi
