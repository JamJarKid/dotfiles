#!bin/bash

# Housekeeping

if [ ! -d ~/.config ]; then
    mkdir ~/.config
else
    echo "~/.config exists skipping creation"
fi

if [ ! -d ~/projects ]; then
    mkdir ~/projects
else
    echo "~/projects exists skipping creation"
fi
    
casks=(
    "ghostty"
    "visual-studio-code"
    "obsidian"
    "figma"
    "karabiner-elements"
    "google-chrome"
    "adguard"
    "claude"
    "whatsapp"
    "raycast"
    "scroll-reverser"
    )

cli_tools=(
    "miniforge"
    "node"
    "neovim"
    "font-monaspace-nerd-font"
    "gh"
    "ollama"
    "uv"
    "ruff"
    "ripgrep"
    "prettierd"
    "clang-format"
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
link_file "$HOME/dotfiles/.config/git" "$HOME/.config/git"
    
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

# nvim
# node needed for lsps
link_file  "$HOME/dotfiles/.config/nvim" "$HOME/.config/nvim" 

# tmux
brew install tmux
link_file "$HOME/dotfiles/.config/tmux" "$HOME/.config/tmux"
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
brew install tmux-sessionizer
link_file "$HOME/dotfiles/.config/tms" "$HOME/.config/tms"

# vscode
link_file "$HOME/dotfiles/.config/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json" 
# claude MCP
link_file "$HOME/dotfiles/.config/claude/claude_desktop_config.json" "$HOME/Library/Application Support/Claude/claude_desktop_config.json"


# while IFS= read -r ext; do
#    echo "installing $ext"
#    code --install-extension "$ext"
#done < ./.config/vscode/extensions.txt

# github
gh auth login

# claude mcp
npx -y @smithery/cli install mcp-obsidian --client claude --config '{"vaultPath":"/Users/maliek/MP2"}'


