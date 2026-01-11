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
# karabiner-elements
link_file "$HOME/dotfiles/.config/karabiner" "$HOME/.config/karabiner" 

# git
link_file "$HOME/dotfiles/.config/git/.gitconfig" "$HOME/.gitconfig"
link_file "$HOME/dotfiles/.config/git/.gitignore_global" "$HOME/.gitignore_global"
    
# ghostty config
link_file "$HOME/dotfiles/.config/ghostty" "$HOME/.config/ghostty"

# zsh
if [ ! -d "$HOME/oh-my-zsh" ]; then
    echo "installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "oh-my-zsh already installed"
fi

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

link_file "$HOME/dotfiles/.config/zsh/.zshrc" "$HOME/.zshrc"
link_file "$HOME/dotfiles/.config/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

git clone https://github.com/jeffreytse/zsh-vi-mode \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# vscode
link_file "$HOME/dotfiles/.config/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json" 

while IFS= read -r ext; do
    echo "installing $ext"
    code --install-extension "$ext"
done < ./.config/vscode/extensions.txt

