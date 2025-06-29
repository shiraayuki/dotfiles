# 🧪 Arch Linux Dotfiles (by shiraayuki)

A collection of personal configuration files for a streamlined **Arch Linux** environment.
Designed to be used with [GNU Stow](https://www.gnu.org/software/stow/)

---

## 📁 Contents

| Component  | Description                                      |
|------------|--------------------------------------------------|
| `zsh`      | `.zshrc` configuration with plugins and aliases |
| `starship` | Make your terminal look beautiful               |
| `kitty`    | GPU-accelerated terminal emulator configuration |
| `nvim`     | Neovim setup (Lua-based)                        |
| `vim`      | Simple, fallback `vimrc` for terminal editing   |

---

## 🧰 Usage (with GNU Stow)

> Make sure you have stow installed
> `sudo pacman -S stow`

---

### 🧪 Setup instruction

Fist clone the repository:
```bash
git clone http://github.com/shiraayuki/dotfiles ~/.dotfiles
```

Cd into the repository folder:
```bash
cd ~/.dotfiles
```

To now make use of the config files simply run:
```bash
stow nvim
```
---

## 🔄 Unstow

To remove the config again, run:
```bash
stow -D nvim
```

---

## 📷 Previews (comming soon...)

---

## 📝 License

MIT – feel free to reuse or adapt.
