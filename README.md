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

* https://medium.com/seokjunhong/customize-the-terminal-zsh-iterm2-powerlevel10k-complete-guide-for-beginners-35c4ba439055
* [powerlevel10k](https://github.com/romkatv/powerlevel10k/tree/master#getting-started)
* [foundry](https://book.getfoundry.sh/getting-started/installation)

### iTerm key mappings

* Preferences > Profiles > Keys > General
  * Left Option Key > Esc+
* Preferences > Profiles > Keys > Key Mappings

| shortcut |        action        | Esc+ |     Description       |
|----------|----------------------|------|-----------------------|
| ⌘←       | Send Escape Sequence |  OH  | Jump start of line    |
| ⌘→       | Send Escape Sequence |  OF  | Jump end of line      |
| ⌥←       | Send Escape Sequence |  b   | Jump 1 word back      |
| ⌥→       | Send Escape Sequence |  f   | Jump 1 word forward   |
| ⌥c       | Send Escape Sequence |  c   | Opt+C fzf key binding |

## Vim

* [basic vimrc](https://github.com/amix/vimrc#how-to-install-the-basic-version) - 

```bash
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.shgs
```

## Go

```bash
mkdir -p $HOME/go/{bin,src,pkg}
```

## Rust

```bash
rustup-init
```

## MacOS

* System Preferences > Security & Privacy > Firewall > Turn on Firewall
* System Preferences > Date & Time > Set timezone automatically (off)
* System Preferences > Date & Time > London - United Kingdom (work time zone)
* System Preferences > Tracking Speed > Fastest
* System Preferences > Mouse > Secondary Click (right side)

## Guides:

* https://www.bradleysawler.com/engineering/macos-initial-setup-of-cli-and-python-dev/