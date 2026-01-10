#!/bin/bash

install_homebrew() {
    if command -v brew  > /dev/null 2>&1; then
        echo "Homebrew already installed"
    else
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.github.usercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

clone_dotfiles() {
    echo "Installing dotfiles"
    cd ~
    git clone https://github.com/JamJarKid/dotfiles.git
    cd ./dotfiles 
}

install_homebrew
clone_dotfiles


