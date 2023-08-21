# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Files
alias ls='exa'
alias ll='exa -ahl'
alias tree='exa --tree'

# Neovim
alias vi='nvim'
alias vim='nvim'

# Meta
alias ez='vim ~/.zshrc'
alias rezsh='. ~/.zshrc'

# Foundry
alias fi='forge install'
alias fb='forge build'
alias ft='forge test'
alias finit='forge init'

# Navigation
alias de='cd ~/Desktop'
alias ds='cd ~/Documents'
alias dsc='cd ~/Documents/coding'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# mv, rm, cp
alias rm='rm -v'
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

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gau='git add --update'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit'
alias gcms='git commit -m'
alias gca='git commit -v -a'
alias gd='git diff'
alias gdc='git diff --cached'
alias gcl='clone'
alias gra='git remote add'
alias gp='git push'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gpum='git pull origin master'
alias gu='git pull'
alias gt='git tag'
alias grs='git reset'
alias grv='git revert'
alias gcp='git cherry-pick'
alias gm='git merge'
alias gco='git checkout'
alias gcob='git checkout -b'
alias got='git checkout -t'
alias gotb='git checkout --track -b'
alias gl='git log'
alias glo='git log --pretty=oneline '
alias gh='git hist'
alias gpgp='git push origin gh-pages'
alias guru='git pull --rebase upstream master'
alias gsh='git stash'
alias gsa='git stash apply'
alias gsp='git stash pop'
alias grbk='git rebase --skip'

# go
export GOPATH=$HOME/Documents/coding/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Zip
alias ungz="gunzip -k"

# File size
alias fs="stat -f \"%z bytes\""

# Node
alias n='npm'
alias ni='n install'
alias ns='n start'
alias nt='n test'
alias nr='n run'

# curl
alias cpj='curl -H "Content-Type: application/json" -X POST -d'
alias cgj='curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET'

# Files
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Brew / NPM Update
alias brew_update="brew -v update && brew upgrade --force-bottle --cleanup && brew cleanup && brew cask cleanup && brew prune && brew doctor && npm-check -g -u"
alias update_brew_npm='brew_update && npm install npm -g && npm update -g'

# Helper functions

# combine mkdir and cd
md() {
  mkdir "$1"
  cd "$1"
}

# combine touch and code
tcode() {
  touch "$1"
  code "$1"
}

killf() {
  if ps -ef | sed 1d | fzf -m | awk '{print $2}' > $TMPDIR/fzf.result
  then
    kill -9 (cat $TMPDIR/fzf.result)
  fi
}

clone() {
    git clone --depth=1 $@
    cd (basename $2 | sed 's/.git$//')
    pnpm install
}

# Use `which` along with symlink resolving
whichlink() {
	$(type -p greadlink readlink | head -1) -f $(which $@)
}

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# source /usr/local/etc/profile.d/z.sh

eval "$(/opt/homebrew/bin/brew shellenv)"

# Rust
. "$HOME/.cargo/env"

# Power Level
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
