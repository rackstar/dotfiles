
##############################################################################################################
###  backup old machine's key items

mkdir -p ~/migration/home/
mkdir -p ~/migration/Library/"Application Support"/
mkdir -p ~/migration/Library/Preferences/
mkdir -p ~/migration/Library/"Group Containers"
mkdir -p ~/migration/rootLibrary/Preferences/SystemConfiguration/

cd ~/migration

# what is worth reinstalling?
npm list -g --depth=0    > npm-g-list.txt

# backup some dotfiles likely not under source control
cp -Rp \
    ~/.gitconfig.local \
    ~/.ssh \
    ~/.z \
        ~/migration/home

# Documents
cp -Rp ~/Documents ~/migration

# Brave Browser
cp -Rp ~/Library/Application\ Support/BraveSoftware ~/migration/Library/"Application Support"

# Notes
cp -Rp ~/Library/Group\ Containers/group.com.apple.notes ~/migration/Library/"Group Containers"

# WiFi
cp -Rp /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist ~/migration/rootLibrary/Preferences/SystemConfiguration/

# Fonts
cp -Rp ~/Library/Fonts ~/migration/Library/


# also consider...
# random git branches you never pushed anywhere?
# git untracked files (or local gitignored stuff). stuff you never added, but probably want..


# OneTab history pages, because chrome tabs are valuable.

# usage logs you've been keeping.

# iTerm settings.
  # Prefs, General, Use settings from Folder

# maybe ~/Pictures and such
cp -Rp ~/Pictures ~/migration

# Brew (creates Brewfile)

brew bundle dump

# VSCode

# extensions
code --list-extensions | xargs -L 1 echo code --install-extension > vscode/ext

# settings
cp ~/Library/Application\ Support/Code/User/settings.json vscode