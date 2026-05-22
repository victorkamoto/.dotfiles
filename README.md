# dotfiles

> A reproducible workstation in one command. Arch Linux and Ubuntu (WSL) supported, fully idempotent, no babysitting.

<!-- SCREENSHOT: hero shot.
     Suggested: a wide terminal screenshot showing zsh + starship prompt with
     git-status info, an `eza --git --icons` listing, and the bottom edge of
     tmux's status bar visible. Recommended size: ~1600x900, .png or .webp.
     Save under docs/img/hero.png and uncomment:
-->
<!-- ![hero](docs/img/hero.png) -->

```bash
git clone https://github.com/victorkamoto/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
ansible-galaxy collection install -r requirements.yml
ansible-playbook setup.yml
```

That's it. Make coffee. Come back to a working dev box.

<!-- SCREENSHOT/GIF: playbook run.
     Suggested: a terminal asciinema cast or GIF of `ansible-playbook setup.yml`
     running on a fresh box, showing the cowsay tasks ticking through and the
     final "DOTFILES SETUP COMPLETE" banner. Tools: asciinema + agg, or
     terminalizer. Recommended size: ~1200px wide, <2MB.
     Save under docs/img/install.gif and uncomment:
-->
<!-- ![install run](docs/img/install.gif) -->

---

## What you get

| Layer | Tool |
|---|---|
| Shell | **zsh** + autosuggestions + syntax highlighting |
| Prompt | **starship** |
| Multiplexer | **tmux** + [TPM](https://github.com/tmux-plugins/tpm) plugins |
| Session manager | **[sesh](https://github.com/joshmedeski/sesh)** (bound to `prefix + T`) |
| Editor | **neovim** with [LazyVim](https://www.lazyvim.org/) |
| Git TUI | **lazygit** |
| File listing | **eza** (with icons + git integration) |
| Fuzzy finder | **fzf** + [fzf-git.sh](https://github.com/junegunn/fzf-git.sh) |
| Smart `cd` | **zoxide** (aliased to `cd`) |
| Better `cat` | **bat** (gruvbox-dark theme) |
| Better `find` | **fd** |
| Better `grep` | **ripgrep** |
| Modern man pages | **tldr** (via tlrc) |
| Worktree manager | **[worktrunk](https://github.com/victorkamoto/worktrunk)** (`wt`) |
| AI dev assistant | **[opencode](https://opencode.ai/)** |
| Runtimes | Node.js LTS (via NVM), Go, Rust (via rustup), Python |
| Compositor (Arch only) | **Hyprland** + **Quickshell** + **kitty** |

Everything is symlinked from this repo via [GNU stow](https://www.gnu.org/software/stow/), so editing a config in `~/.config/...` edits it here and `git diff` just works.

<!-- SCREENSHOT: neovim / LazyVim in action.
     Suggested: an editor screenshot with the file tree open on the left, a
     code buffer in the middle (something with syntax highlighting and an
     LSP signature popup or diagnostic visible), and lualine at the bottom.
     Recommended size: ~1600x1000.
     Save under docs/img/nvim.png and uncomment:
-->
<!-- ![neovim](docs/img/nvim.png) -->

---

## Why Ansible?

Bash install scripts rot. They run twice and break, fail halfway and leave you in a broken state, and tell you nothing about what changed. The `setup.yml` playbook in this repo is:

- **Idempotent.** Re-run it any time. Nothing reinstalls unless it has to.
- **Self-documenting.** Every step is a named task with a description.
- **Two-platform.** Same playbook handles Arch and Ubuntu. The dotfiles themselves auto-detect the OS.
- **Safe.** Asks for sudo once at the start. `--check` mode shows what would change.

---

## Prerequisites

You need git, ansible, and a working internet connection. Everything else, the playbook handles.

**Arch Linux:**
```bash
sudo pacman -S --needed git ansible
```

**Ubuntu / WSL:**
```bash
sudo apt update && sudo apt install -y git ansible
```

If you're on a fresh WSL install, make sure your user exists and is in the `sudo` group before running the playbook.

---

## Install

```bash
# 1. Clone
git clone https://github.com/victorkamoto/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 2. Install the Ansible collection (first time only)
ansible-galaxy collection install -r requirements.yml

# 3. Run it
ansible-playbook setup.yml
```

You'll be prompted **once** for your sudo password. Ansible reuses it for every privileged task — no second prompts, no `--ask-become-pass` flag needed.

To preview changes without applying them:

```bash
ansible-playbook --check setup.yml
```

Note: in `--check` mode, `shell:`/`command:` tasks are skipped (Ansible can't predict their effect without running them). That's normal.

---

## Day-to-day

### Updating everything

Just re-run the playbook. It pulls the latest dotfiles, upgrades system packages, refreshes cargo tools, and re-stows everything in under a minute.

```bash
cd ~/.dotfiles && ansible-playbook setup.yml
```

### Updating just a config

Edit the file in this repo — for example `nvim/.config/nvim/lua/config/keymaps.lua` — and the change is already live via the stow symlink. Commit when you're happy.

### Adding a new tool

1. Add it to the `system_packages` block in `setup.yml` (under the right OS), or add an install task if it's not in the system repos.
2. Add any config under a new top-level directory (e.g. `helix/.config/helix/`) and add `helix` to the `stow_dirs` list.
3. Re-run the playbook.

---

## Tmux cheatsheet

Prefix is **backtick** (`` ` ``), not the default `C-b`.

| Keys | Action |
|---|---|
| `` ` ` `` | Send a literal backtick |
| `` ` ``  `R` | Reload tmux config |
| `` ` ``  `a` | Toggle to last window |
| `` ` ``  `|` | Split pane horizontally (preserves cwd) |
| `` ` ``  `-` | Split pane vertically (preserves cwd) |
| `M-H` / `M-L` | Previous / next window |
| `` ` ``  `T` | Open sesh session picker |
| `` ` ``  `L` | Jump to last sesh session |
| `` ` ``  `9` | Connect to root session of current dir |
| `` ` ``  `I` | Install / update TPM plugins |
| `` ` ``  `x` | Kill pane (no confirmation prompt) |

Copy-mode is vi-style: `v` to start selection, `C-v` for rectangular, `y` to yank.

<!-- SCREENSHOT: tmux + sesh picker.
     Suggested: a tmux window with the sesh fzf picker open (hit `T` from any
     session), showing a list of recent sessions/zoxide dirs with preview pane
     on the right. Good for showing off the workflow.
     Save under docs/img/tmux-sesh.png and uncomment:
-->
<!-- ![tmux sesh picker](docs/img/tmux-sesh.png) -->

---

## Repo layout

```
.dotfiles/
├── setup.yml              # the Ansible playbook
├── requirements.yml       # Ansible collection deps
├── nvim/.config/nvim/     # LazyVim config
├── zsh/.zshrc             # zsh config (OS-aware)
├── tmux/.config/tmux/     # tmux + TPM + sesh bindings
├── starship/.config/      # prompt config
├── kitty/.config/kitty/   # terminal (Arch / Hyprland)
├── hypr/.config/hypr/     # Hyprland (Arch only)
└── quickshell/.config/    # Quickshell (Arch only)
```

Each top-level directory mirrors `$HOME`. Stow walks the tree and creates symlinks. The Ubuntu stow set is a subset — `hypr`, `kitty`, and `quickshell` are Arch-only because WSL has no compositor.

<!-- SCREENSHOT: Hyprland desktop (Arch only).
     Suggested: a full desktop screenshot with the Quickshell bar visible, a
     kitty window, and maybe a second tiled app. This is the "rice" shot — the
     one people scroll to first. Recommended size: full resolution of your
     display, downscaled to ~1920px wide.
     Save under docs/img/desktop.png and uncomment:
-->
<!-- ![hyprland desktop](docs/img/desktop.png) -->

---

## WSL notes

A few WSL-specific things the playbook can't do for you:

**Nerd Font.** Icons in tmux, nvim, starship, and eza need a Nerd Font, but WSL has no fonts of its own — they live on the Windows side.

1. Download [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads).
2. Extract the `.ttf` files, right-click each → **Install for all users**.
3. Windows Terminal → Settings → Profiles → Ubuntu → Appearance → Font face → **JetBrainsMono Nerd Font**.
4. Restart Windows Terminal.

**Default shell didn't stick?** Check `/etc/wsl.conf` — a `[user] default=...` block there overrides what `chsh` set. Comment it out or update it to `zsh`.

**Clipboard.** Out of the box, tmux's `set-clipboard on` works through Windows Terminal's OSC 52 support. If it doesn't, install `wsl-clipboard` or alias `pbcopy=clip.exe`.

---

## Troubleshooting

**"command not found: stow" / "ansible" after running the playbook.**
The playbook installs these. If they're already missing before the playbook starts, install them manually first (see [Prerequisites](#prerequisites)).

**Cargo tools don't upgrade.**
They do — `cargo install` is the idempotency check, and re-running the playbook will upgrade `worktrunk` and `tlrc` to the latest version. If you want to skip the rebuild, comment out the `Rust | Install / upgrade cargo tools` task.

**Tmux plugins missing after first install.**
The playbook runs `install_plugins.sh` headlessly, but if that fails (no `$DISPLAY`, weird PATH), just open tmux and press `` ` `` + `I`.

**Neovim icons look broken.**
Nerd Font isn't installed in your terminal. See [WSL notes](#wsl-notes), or on Arch confirm `ttf-jetbrains-mono-nerd` is installed and your terminal is set to use it.

**WSL says zsh isn't your default shell.**
Run `chsh -s /usr/bin/zsh` and start a new WSL session. If that still doesn't work, see [WSL notes](#wsl-notes).

**The playbook failed halfway.**
Just re-run it. Every task is idempotent — work that succeeded is skipped on the next run, and Ansible picks up from where it left off.

---

## License

MIT — see [LICENSE](LICENSE). Steal what you like.

The bundled LazyVim config (`nvim/.config/nvim/`) has its own LICENSE inherited from the upstream starter; everything else is mine.
