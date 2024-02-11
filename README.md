# dotfiles
These are my dotfiles. Feel free to plagiarize.

## Overview
Here's a list of what my dotfiles cover:
- `neovim` - Configuration for neovim text editor
- `scripts` - General scripts I use
- `tmux` - Configuration for tmux which is an awesome terminal multiplexer
- `wezterm` - Terminal powered by Rust and configured with Lua

### TODO:
- [x] Make a dotfiles repository.
- [ ] I should add formatter support to my `neovim` config
- [ ] Need undotree...
- [ ] Try out the fish shell (aka learn how to fish)
- [ ] Make some more cool utilities using `fzf`
- [ ] Make `tmux` configuration suck slightly less
- [ ] Make `wezterm` configuration suck slightly less (I don't have
      keybindings for zooming in)
- [ ] Seamless theme switching

## Setup
### Prerequisites
This repository uses GNU Stow to manage symlinks between this repository and
the home directory.

#### Mac
Install GNU Stow using `brew`:
```
brew install stow
```
#### Linux
Tune in for the next episode of my life for when I actually use Linux again.

### Cloning
This includes tmux's TPM as a submodule so don't forget to include submodules
when cloning!
```
git clone --recurse-submodules git@github.com:scarydoors/dotfiles.git ~/.dotfiles
```
