# ----------------------------------------------------------------------
# | Zsh                                                                |
# ----------------------------------------------------------------------

# Powerlevel10k instant prompt
# Should stay close to the top of ~/.zshrc. Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Powerlevel10k
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Plugins
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# ----------------------------------------------------------------------
# | Bin                                                                |
# ----------------------------------------------------------------------

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Go
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Rust
. "$HOME/.cargo/env"

# Brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# ----------------------------------------------------------------------
# | Aliases                                                               |
# ----------------------------------------------------------------------

# Files
alias ls="exa"
alias ll="exa -ahl"
alias tree="exa --tree"

# Neovim
alias vi="nvim"
alias vim="nvim"

# Meta
alias ez="vim ~/.zshrc"
alias rezsh="source ~/.zshrc"
alias grep="grep --color=auto"

# Foundry
alias fi="forge install"
alias fb="forge build"
alias ft="forge test"
alias finit="forge init"

# Navigation
alias de="cd ~/Desktop"
alias ds="cd ~/Documents"
alias dsc="cd ~/Documents/code"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

## TODO: git aliases
#
# mv, rm, cp
alias rm="rm -v"
#             └─ verbose, showing files as they are removed

alias cp="cp -iv"
#             │└─ list copied files
#             └─ prompt before overwriting an existing file

alias mkdir="mkdir -pv"
#                   │└─ list created directories
#                   └─ create intermediate directories

alias mv="mv -iv"
#             │└─ list moved files
#             └─ prompt before overwriting an existing file

# Permissions
alias chmodx="chmod +x"

# Zip
alias ungz="gunzip -k"

# File size
alias fs="stat -f \'%z bytes\'"

# curl
alias cpj="curl -H 'Content-Type: application/json' -X POST -d"
alias cgj="curl -i -H 'Accept: application/json' -H 'Content-Type: application/json' -X GET"

# Brew / NPM Update
alias brew_update="brew -v update && brew upgrade --force-bottle --cleanup && brew cleanup && brew cask cleanup && brew prune && brew doctor && npm-check -g -u"
alias update_brew_npm="brew_update && npm install npm -g && npm update -g"

# OSX Files
alias showFiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app"
alias hideFiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app"
