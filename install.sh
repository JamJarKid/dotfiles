#!bin/bash

# Housekeeping

mkdir ~/.config

casks=(
    "ghostty"
    "visual-studio-code"
    "obsidian"
    "figma"
    "karabiner-elements"
    "miniforge"
    "google-chrome"
    "adguard"
    "claude"
    "whatsapp"
    "font-monaspace-nerd-font"
    "raycast"
    )

for program in "${casks[@]}"
do
    if brew list --cask $program > /dev/null 2>&1; then
        echo "$program installed"
    else
        brew install --cask $program
        open -a $program
        read -n 1 -s -r -p "Press Any Key after you finish setting-up the current app"
    fi
done
    
# ghostty config

mkdir ~/.config/ghostty
ln -s "$HOME/dotfiles/.config/ghostty" "$HOME/.config/ghostty"

# karabiner-elements

ln -s "$HOME/dotfiles/.config/karabiner" "$HOME/.config/karabiner" 
