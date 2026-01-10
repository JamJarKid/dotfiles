#bin/bash

casks=(
    "iterm2"
    "visual-studio-code"
    "obsidian"
    "figma"
    "karabiner-elements"
    "miniforge"
    "chrome"
    "adguard"
    )

for program in casks
do
    if brew list $program; then
        echo "$program installed"
    else
        brew install --cask $program
done
    
