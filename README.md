# Mac provisioner and configuration updater

## Getting Started

------------------

### Installation

This tool supports modern macOS (apple silicon only).

To install, just run this command:

```bash
$SHELL <(curl -fsSL 'https://raw.githubusercontent.com/acalvino4/provision-mac/main/installer')
```

Provisioning will take about 5 minutes.

### Updates

Need the latest .vimrc? Just run `rock update` from any directory - the executable is on your path after installation.

## Features

------------------

### Aliases & Tab Completion

No need to come up with your own aliases, if there is a tool you use often, chances are there's an [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins-Overview_) plugin to help you out. Besides coming with tab completion, using these aliases brings a level of standardization and makes it unlikely you'd conflict with an alias for another tool.

Enabling a plugin is as simple as `omz plugin enable <name>`. You'll do this based on what tools you run - for example, if you have a php app you'll probably use the `composer` plugin. Some of these are enabled by default. [Browse availible plugins here](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)

### Vim

#### Keybindings

This module loads a robust vim config - besides configuring many nice things that you don't even have to think about, it initializes the following non-standard (but common) keybindings:

* \<leader> - \[space]
* zo - open code fold
* zc - close code fold
* W  - sudo save
* Wq - sudo save & exit
* jk - enter normal mode (easier than [esc])
* kj - also, enter normal mode (so you can just smash both keys at once)
* B  - move to beginning of line
* E  - move to end of line
* L  - toggle line numbers (for copying with a mouse selection from a remote)

#### Plugins

You can also add your own vim plugins. Create `~/.vim/personal-plugins.vim` and list your plugins (one per line):

```vim
tpope/vim-surround
author/repo-name
...
```

Run `rock update:vim` after modifying the file for changes to take effect.

Browse [VimAwesome](https://vimawesome.com/) or search github for available plugins.
