if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias chrome="open -a 'Google Chrome'"
alias python="/usr/local/bin/python3.10"
alias pip="/usr/local/bin/pip3.10"
alias gcc="gcc-13"
alias g++="g++-13"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ "$OSTYPE" == "darwin"* ]]; then
  # MacOS with Homebrew
  export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
fi
export MODULAR_HOME="/Users/maliek/.modular"
export PATH="/Users/maliek/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
