# Contributing Guide

## Directory Overview
- `bin` - scripts for rock's direct subcommands
- `config` - server configuration files
- `lib` - helper scripts which get called by the main commands
- `scripts` - arbitrary scripts for use on the servers; run through `rock run`

## Required Practices

To ensure that this project has clean installs, upgrades, & uninstalls, the following filesystem modifications by any part of the script MUST be reversed in `lib/cleanup.sh`:
- files added outside this repo
- lines added to existing system files

To make it clear which files and changes are the result of this project, and to ensure smoother updates, we should observe the following ***wherever possible***
- always add files to included `.d` config directories rather than modifying config files directly
- label added files with "rock" as part of name
- label additions to existing files with a trailing comment ` # Managed by rock`
- if an addition is removed, remove the corresponding cleanup from `lib/cleanup.sh`

### Exceptions
- installed software can stay (i.e. zsh, plocate, etc.)
- configured users can stay

## Utility Scripts
Feel free to submit PR's for utility scripts that you would like included. They should be placed under the `scripts` directory, and will be runnable with `rock run my-script`. Document your custom script in `SCRIPTS.md`

## Vim
Unless there is a good reason not to, any changes to `config/vimrc` should be merged to the Ubuntu version of this repo. Document significant features in README

## Development environment
Install recommended extensions, as well as `shellcheck` and `shfmt`
```
brew install shfmt
brew install shellcheck
```

Note that these tools will give some false positives - feel free to ignore their warnings if you know what you are doing, but note that most errors will prevent your code from merging. Currently the exceptions are 1090, 1091, 2034, and 2154.

## TODO
-------
- configure merge check with `shfmt` and `shellcheck`; errors 1090, 1091, 2034, 2154 can be ignored
- bash completions for subcommands
- setup proper merge restrictions in BB
- Investigate https://github.com/mrzool/bash-sensible and https://github.com/tpope/vim-sensible for possible merging with our configs
- test vim undo, copy/paste clipboard
- See if there is a way to include user-specific vim plugins with this setup
- proper order of bin dirs in /etc/paths
- audit vscode extension list
