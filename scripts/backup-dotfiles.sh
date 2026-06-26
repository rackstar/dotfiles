#!/bin/bash
set -euo pipefail

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

DOTFILES="/Users/rocky/code/dotfiles"
CLAUDE_DIR="/Users/rocky/.claude"
DATE=$(date '+%Y-%m-%d')

log() { echo "[$(date '+%H:%M:%S')] $*"; }

# --- Dotfiles: regenerate dynamic files ---
log "Regenerating dynamic files..."
brew bundle dump --file="$DOTFILES/Brewfile" --force 2>&1 || log "brew dump failed (skipping)"
mas list > "$DOTFILES/Masfile" 2>/dev/null || log "mas list failed (skipping)"

# --- Dotfiles: commit & push ---
log "Backing up dotfiles..."
git -C "$DOTFILES" add -A
if ! git -C "$DOTFILES" diff --cached --quiet; then
    git -C "$DOTFILES" commit -m "chore: backup $DATE"
    git -C "$DOTFILES" push
    log "Dotfiles pushed."
else
    log "Dotfiles: nothing to commit."
fi

# --- .claude: commit & push ---
log "Backing up .claude..."
git -C "$CLAUDE_DIR" add -A
if ! git -C "$CLAUDE_DIR" diff --cached --quiet; then
    git -C "$CLAUDE_DIR" commit -m "chore: backup $DATE"
    git -C "$CLAUDE_DIR" push
    log ".claude pushed."
else
    log ".claude: nothing to commit."
fi

log "Done."
