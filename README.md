## NVM

* https://github.com/nvm-sh/nvm#install--update-script
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
```

## Install Apps (not available in homebrew)

* [whatsapp silicon](https://web.whatsapp.com/desktop/mac_native/release/)

## VSCode Backup

Backup Extension
```bash
code --list-extensions | xargs -L 1 echo code --install-extension > vscode/ext
```

Backup settings.json
```bash
cp ~/Library/Application\ Support/Code/User/settings.json vscode
```

## iTerm

* https://medium.com/seokjunhong/customize-the-terminal-zsh-iterm2-powerlevel10k-complete-guide-for-beginners-35c4ba439055
* [powerlevel10k](https://github.com/romkatv/powerlevel10k/tree/master#getting-started)
* rustup-init
* [foundry](https://book.getfoundry.sh/getting-started/installation)

## Guides:
* https://sourabhbajaj.com/mac-setup/SystemPreferences/
* https://www.bradleysawler.com/engineering/macos-initial-setup-of-cli-and-python-dev/