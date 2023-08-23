#!/bin/bash

source './utils.sh'

# this symlinks all the dotfiles, settings.json and hammerspoon/init.lua
# this is safe to run multiple times and will prompt you about anything unclear
# based on https://raw.githubusercontent.com/alrra/dotfiles/master/os/create_symbolic_links.sh

# finds all .dotfiles in this folder
declare -a FILES_TO_SYMLINK=$(find . -type f -maxdepth 1 -name ".*" -not -name .DS_Store -not -name .git -not -name .macos | sed -e 's|//|/|' | sed -e 's|./.|.|' | sort)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## symlink dot files

main() {

    local i=""
    local sourceFile=""
    local targetFile=""

    for i in ${FILES_TO_SYMLINK[@]}; do

        sourceFile="$(pwd)/$i"
        targetFile="$HOME/$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        if [ -e "$targetFile" ]; then
            if [ "$(readlink "$targetFile")" != "$sourceFile" ]; then

                ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
                if answer_is_yes; then
                    rm -rf "$targetFile"
                    sym_link $sourceFile $targetFile
                else
                    print_error "$targetFile → $sourceFile"
                fi

            else
                print_success "$targetFile → $sourceFile"
            fi
        else
            sym_link $sourceFile $targetFile
        fi

    done

}

main

## Other files (settings.json, init.lua etc..)

# symlink VSCode settings.json 
sym_link "$(pwd)/vscode/settings.json" "~/Library/Application\ Support/Code/User/settings.json"

# symlink hammerspoon/init.lua
sym_link "$(pwd)/.hammerspoon/init.lua" "~/.hammerspoon/init.lua"