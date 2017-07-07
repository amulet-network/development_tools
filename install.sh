#!/bin/zsh -l

autoload colors

if [[ "$terminfo[colors]" -gt 8 ]]
then
  colors
fi

for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE
do
  eval $COLOR='$fg_no_bold[${(L)COLOR}]'
  eval BOLD_$COLOR='$fg_bold[${(L)COLOR}]'
done

eval RESET='$reset_color'

local XCODE_SELECT_REGEX=".*xcode-select.*"

local RED_PERIOD="${RED}.${RESET}"

function warning {
  echo "${RED}${1}${RESET}"
}

function success {
  echo "${GREEN}${1}${RESET}"
}

local git_version="$(git --version 2>&1 1>/dev/null)"

if [[ $git_version =~ $XCODE_SELECT_REGEX ]]
then
  warning "Developer Tools not installed, prompting for install and waiting."
  while [[ $(git --version 2>&1 1>/dev/null) =~ $XCODE_SELECT_REGEX ]]
  do
    sleep 2
    echo -n ${RED_PERIOD}
  done
  echo "${RESET}"
fi

success "Git found, continuing..."

if (( $+commands[brew] ))
then
  success "Brew found, continuing..."
else
  warning "Brew not found, installing..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  success "Brew is now installed."
fi

success "Installing Ethereum"
brew tap ethereum/ethereum

if (( $+commands[solc] ))
then
  success "solc found, continuing..."
else
  warning "solc not found, installing..."
  brew install solidity
  success "solc is now installed."
fi


if (( $+commands[geth] ))
then
  success "geth found, continuing..."
else
  warning "geth not found, installing..."
  brew install ethereum
  success "geth is now installed."
fi
