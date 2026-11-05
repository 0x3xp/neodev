# 🛠️ Detailed Installation Guide

This guide walks through setting up this Neovim configuration on Linux, macOS, or WSL.

---

## 1. System Dependencies

Before launching Neovim, install the required base tools and compilers:

### Debian / Ubuntu / Kali
```bash
sudo apt update
sudo apt install -y \
  neovim \
  git \
  curl \
  build-essential \
  clang \
  clangd \
  gdb \
  xxd \
  ripgrep \
  fd-find
```

### Arch Linux
```bash
sudo pacman -Syu --needed \
  neovim \
  git \
  curl \
  base-devel \
  clang \
  gdb \
  xxd \
  ripgrep \
  fd
```

### Fedora
```bash
sudo dnf install -y \
  neovim \
  git \
  curl \
  make \
  gcc \
  gcc-c++ \
  clang \
  clang-tools-extra \
  gdb \
  vim-common \
  ripgrep \
  fd-find
```

---

## 2. Rust Toolchain (Optional but Recommended)

If you compile or debug Rust projects, install the official Rust toolchain:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
rustup component add rust-analyzer clippy rustfmt
```

---

## 3. Font Setup (JetBrainsMono Nerd Font)

NvChad relies on icons for git status, diagnostic signs, and file explorers. Install the patched **JetBrainsMono Nerd Font**:

### Linux
```bash
mkdir -p ~/.local/share/fonts/JetBrainsMono
curl -fLo /tmp/jb.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf /tmp/jb.tar.xz -C ~/.local/share/fonts/JetBrainsMono
rm /tmp/jb.tar.xz
fc-cache -f ~/.local/share/fonts
```

Verify the font is installed:
```bash
fc-list : family | grep -i "JetBrainsMono Nerd Font"
```

Configure your terminal emulator (e.g. Alacritty, Kitty, WezTerm, QTerminal) to use `JetBrainsMono Nerd Font`.

---

## 4. Deploying the Configuration

1. **Backup existing config**:
   ```bash
   [ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak.$(date +%s)
   [ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.bak.$(date +%s)
   ```

2. **Clone and copy**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/neodev.git ~/neodev
   cp -r ~/neodev/nvim ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```
   `lazy.nvim` will initialize and clone all core plugins automatically.

---

## 5. Post-Install Verification

Inside Neovim, run these commands:

1. **Install Language Servers**:
   ```vim
   :MasonInstall rust-analyzer clangd asm-lsp
   ```

2. **Check Diagnostics & Health**:
   ```vim
   :checkhealth
   ```
   Verify that `nvim`, `treesitter`, and `lsp` report OK.

3. **Verify Active LSP in a File**:
   Open a C or Rust file and run:
   ```vim
   :LspInfo
   ```
   You should see `clangd` or `rust_analyzer` listed as an active client.
