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

# FZF

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# use fd instead of find
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# zoxide
eval "$(zoxide init zsh)"

# ----------------------------------------------------------------------
# | Aliases                                                            |
# ----------------------------------------------------------------------

# Files
alias cd="z"
alias ls="exa"
alias cat="bat"
alias ll="exa -ahl"
alias tree="exa --tree"
alias find="fd"

# Neovim
alias v="nvim"
alias vi="nvim"
alias vim="nvim"

# Meta
alias ez="vim ~/.zshrc"
alias rezsh="source ~/.zshrc"
alias grep="grep --color=auto"

# Foundry
alias f="forge"
alias fint="forge install"
alias fb="forge build"
alias ft="forge test"

# Navigation
alias de="cd ~/Desktop"
alias ds="cd ~/Documents"
alias dsc="cd ~/Documents/code"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Git
alias g="git"
alias gs="g status"
alias ga="g add"
alias gb="g branch"
alias gba="g branch -a"
alias gbls="g for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gc="g commit -v"
alias gca="g commit -v -a"
alias gcms="g commit -m"
alias gd="g diff"
alias gdc="g diff --cached"
alias gcl="g clone"
alias gra="g remote add"
alias gp="g push"
alias gpo="g push origin"
alias gu="g pull"
alias gur="g pull --rebase"
alias grs="g reset"
alias grv="g revert"
alias gm="g merge"
alias gco="g checkout"
alias gcob="g checkout -b"
alias gcot="g checkout -t"
alias gcotr="g checkout --track -b"
alias gl="g log"
alias gh="g hist"
alias gur="g pull --rebase"
alias gsh="g stash"
alias gsa="g stash apply"
alias gsp="g stash pop"
alias grbc="g rebase --continue"
alias grbk="g rebase --skip"
alias gcp="g cherry-pick"

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

# Node
alias n="npm"
alias ni="n install"
alias ns="n start"
alias nt="n test"
alias nr="n run"

# curl
alias cpj="curl -H 'Content-Type: application/json' -X POST -d"
alias cgj="curl -i -H 'Accept: application/json' -H 'Content-Type: application/json' -X GET"

# OSX Files
alias showFiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app"
alias hideFiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app"

# Brew / NPM Update
alias brew_update="brew -v update && brew upgrade --force-bottle --cleanup && brew cleanup && brew cask cleanup && brew prune && brew doctor && npm-check -g -u"
alias update_brew_npm="brew_update && npm install npm -g && npm update -g"

# ----------------------------------------------------------------------
# | Helper Functions                                                   |
# ----------------------------------------------------------------------

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
  set -e
  if ps -ef | sed 1d | fzf -m | awk '{print $2}' > $TMPDIR/fzf.result
  then
    # kill -9 (cat $TMPDIR/fzf.result)
    echo (cat $TMPDIR/fzf.result)
    echo "TEST - no kill (edit me)"
  fi
}

clone() {
  git clone $@
  cd (basename $2 | sed 's/.git$//')
  pnpm install
}

# Use `which` along with symlink resolving
whichlink() {
  $(type -p greadlink readlink | head -1) -f $(which $@)
}
