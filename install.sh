#!bin/bash

# Housekeeping

if [ ! -d ~/.config ]; then
    mkdir ~/.config
else
    echo "~/.config exists skipping creation"
fi
    
casks=(
    "ghostty"
    "visual-studio-code"
    "obsidian"
    "figma"
    "karabiner-elements"
#    "miniforge"
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

link_file() {
    local src=$1
    local dest=$2
    ln -sfn "$src" "$dest"
}

# git
link_file "$HOME/dotfiles/.gitconfig" "$HOME/.gitconfig"
link_file "$HOME/dotfiles/.gitignore_global" "$HOME/.gitignore_global"
    
# ghostty config
link_file "$HOME/dotfiles/.config/ghostty" "$HOME/.config/ghostty"

# karabiner-elements
link_file "$HOME/dotfiles/.config/karabiner" "$HOME/.config/karabiner" 

# vscode
link_file "$HOME/dotfiles/.config/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json" 

while IFS= read -r ext; do
    echo "installing $ext"
    code --install-extension "$ext"
done < ./.config/vscode/extensions.txt

