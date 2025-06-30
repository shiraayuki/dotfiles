# shiraayuki dotfiles

My personal Arch Linux dotfiles.

## About this project

I have been using Linux – particularly Arch Linux – for quite some time now. I have always appreciated how the system works and developed a strong affinity for editors like Vim and Neovim. However, the system looks rather plain without any customization. That’s why I started personalizing my terminal, editors, and the overall desktop environment to better suit my preferences, while also making sure everything stays clean and not overloaded (unlike some common editors like VS22).

Since I work on multiple machines, I decided to turn this into a dedicated repository and structure it in a way that makes it compatible with GNU Stow. This allows for easy management and deployment of my configurations across different systems.

## Included configuration

This repository currently includes configurations for the following tools and components:

- zsh
- kitty
- starship (combinded with kitty)
- neovim
- vim

More detailed information about all of the configs can be found [here](#configuration-details)

## Getting started

### Install GNU Stow

GNU Stow is a symlink manager that simplifies the management of dotfiles across different directories and systems.

To install it:

**On Arch Linux / Manjaro**
```bash
sudo pacman -S stow
```

**On Debian / Ubuntu-basded systems**
```bash
sudo apt install stow
```

**On Fedora**
```bash
sudo dnf install stow
```

**On macOS (via Homebrew)**
```bash
brew install stow
```

## Using this repository with GNU Stow

1. Clone the reposiory (e.g. into ~/.dotfiles):
```bash
git clone http://github.com/shiraayuki/dotfiles.git ~/.dotfiles
```

2. Cd into your dotfiles directory:
```bash
cd ~/.dotfiles
```

3. Stow the desired configuration:
```bash
stow zsh
stow nvim
stow kitty
```

4. Verfiy: Check your home directory (`~`) to confirm that the relevant files (e.g. `.zshrc`) are now linked correctly.

> Tip: You can run `stow -n <dir>` first to preview what would be linked (dry run), or `stow -D <dir>` to delete symlinks for a specific config.

## Configuration details

### zsh

- Saves the latest 10000 executed commands in a hist file

---

### kitty

- Uses the `catppuccin mocha` theme
- Font is set to `CaskaydiaCove Nerd Font Mono`
- Default shell is zsh
- Keybinds to make `strg + arrwos / backspace` work correctly
- fixed window size on launch

---

### starship

- [Gruvbox Rainbow Preset](https://starship.rs/presets/gruvbox-rainbow) with Catppuccin moch colors.

---

### neovim

#### List of currently used pluings (packer as package manager)

- catppuccin mocha theme
- nvim-tree
- nvim-web-devicons
- lualine
- nvim-treesitter
- fzf-lua
- nvim-lspconfig
- mason.nvim
- mason-lsp.config
- nvim-cmp
- cmp-nvim-lsp
- cmp-buffer
- cmp-path
- cmp-cmdline
- cmp_luasnip
- LuaSnip
- nvim-autopairs
- nvim-ts-autotag
- vimtex
- conform.nvim

---

### vim

> Comming soon...

---

## Previews

> Comming soon...
