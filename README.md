## Backup

backup files that are not symlinked
```bash
sh backup.sh
```

## Setup new machine

```bash
sh setup-new-machine.sh
```

## NVM

* https://github.com/nvm-sh/nvm#install--update-script
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
```

## Install Apps (not available in homebrew)

* [whatsapp silicon](https://web.whatsapp.com/desktop/mac_native/release/)


## iTerm

* Preferences > Profiles > Colors > Color Preset > Solarized Dark
* [powerlevel10k](https://github.com/romkatv/powerlevel10k/tree/master#getting-started)

### iTerm key mappings

* Preferences > Profiles > Keys > General > Left Option Key > Esc+
* Preferences > Profiles > Keys > Key Mappings

|----------|----------------------|------|-----------------------|
| ⌘←       | Send Escape Sequence |  OH  | Jump to start of line |
| ⌘→       | Send Escape Sequence |  OF  | Jump to end of line   |
| ⌥←       | Send Escape Sequence |  b   | Jump 1 word back      |
| ⌥→       | Send Escape Sequence |  f   | Jump 1 word forward   |
| ⌥c       | Send Escape Sequence |  c   | Opt+C fzf key binding |

## Vim

[basic vimrc](https://github.com/amix/vimrc#how-to-install-the-basic-version)

```bash
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh
```

## Go

* install go from Brewfile

```bash
mkdir -p $HOME/go/{bin,src,pkg}
```

## Rust

* install rust from Brewfile

```bash
rustup-init
```

## Foundry

Install `foundryup`
```bash
curl -L https://foundry.paradigm.xyz | bash
```

Run `foundryup` to install foundry
```bash
foundryup
```
## fzf-tab

Clone repo
```bash
mkdir ~/.zsh_plugins
git clone https://github.com/Aloxaf/fzf-tab ~/.zsh_plugins/fzf-tab
```

Add to .zshrc (should be there already)
```bash
source ~/.zshplugins/fzf-tab/fzf-tab.plugin.zsh
```

## MacOS

* System Preferences > Security & Privacy > Firewall > Turn on Firewall
* System Preferences > Date & Time > Set timezone automatically (off)
* System Preferences > Date & Time > London - United Kingdom (work time zone)
* System Preferences > Tracking Speed > Fastest
* System Preferences > Mouse > Secondary Click (right sid)

## Sources:

* https://github.com/paulirish/dotfiles
* https://github.com/mathiasbynens/dotfiles
* https://github.com/alrra/dotfiles
* https://sourabhbajaj.com/mac-setup/
* https://www.bradleysawler.com/engineering/macos-initial-setup-of-cli-and-python-dev/
