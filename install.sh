#!bin/bash

casks=(
    "iterm2"
    "visual-studio-code"
    "obsidian"
    "figma"
    "karabiner-elements"
    "miniforge"
    "google-chrome"
    "adguard"
    "claude"
    "whatsapp"
    )

for program in "${casks[@]}"
do
    if brew list --cask $program > /dev/null 2>&1; then
        echo "$program installed"
    else
        brew install --cask $program
        open -a $program
        read -n 1 -s -r -p
    fi
done
    
