# Arch Linux Dotfiles (by shiraayuki)

A collection of personal configuration files for a streamlined **Arch Linux** environment.
Designed to be used with [GNU Stow](https://www.gnu.org/software/stow/)

---

| Component | Description                                  |
|----------------------------------------------------------|
| zsh       |                                              |
| starship  | make your terminal look beautiful            |
| kitty     | cool fonts :)                                |
| nvim      | intellisense, nerdtree and many more plugins |
| vim       | simple fallback vim config                   |

---

## Usage (with GNU Stow)

> Make sure you have stow installed
> `sudo pacman -S stow`

### Setup instruction

```bash
git clone http://github.com/shiraayuki/dotfiles ~/.dotfiles
```

```bash
cd ~/.dotfiles
```

To now make use of the config files simply run:
```bash
stow nvim
```
