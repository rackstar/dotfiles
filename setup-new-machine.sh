# copy paste this file in bit by bit.
# don't run it.
  echo "do not run this script in one go. hit ctrl-c NOW"
  read -n 1

## sh setup-new-machine.sh <migration_dir_root_path>

copyMigration() {
  cp -Rp $1/home/ ~/
  cp -Rp $1/Library/"Application Support"/ ~/Library/"Application Support"/
  cp -Rp $1/Library/"Group Containers" ~/Library/"Group Containers"
  cp -Rp $1/rootLibrary/Preferences/SystemConfiguration/ /Library/Preferences/SystemConfiguration/
  cp -Rp $1/Library/Fonts/ ~/Library/Fonts/
  cp -Rp $1/Pictures ~/Pictures
}

copyMigration

### end of old machine backup
##############################################################################################################
##############################################################################################################
### XCode Command Line Tools
#      thx https://github.com/alrra/dotfiles/blob/ff123ca9b9b/os/os_x/installs/install_xcode.sh

if ! xcode-select --print-path &> /dev/null; then

    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? 'Install XCode Command Line Tools'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    print_result $? 'Make "xcode-select" developer directory point to Xcode'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'

fi

##############################################################################################################
### homebrew

# Install Brewfile in new machine
brew bundle Brewfile

##############################################################################################################
### VSCode

# install extensions
sh vscode/ext

## symlink vscode/settings.json
local sourceFile="$(pwd)/vscode/settings.json"
local targetFile="~/Library/Application\ Support/Code/User/settings.json"
execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"

##############################################################################################################
### hammerspoon

## symlink init.lua
sourceFile="$(pwd)/hammerspoon/init.lua"
targetFile="~/.hammerspoon/init.lua"
execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"

##############################################################################################################

# go read mathias, paulmillr, gf3, alraa's dotfiles to see what's worth stealing.

sh .macos

##############################################################################################################
### symlinks to link dotfiles into ~/
###

#   move git credentials into ~/.gitconfig.local    	http://stackoverflow.com/a/13615531/89484
#   now .gitconfig can be shared across all machines and only the .local changes

# symlink it up!
./symlink-setup.sh

# add manual symlink for .ssh/config

###
##############################################################################################################