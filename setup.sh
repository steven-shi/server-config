#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
# zsh
sudo apt update && sudo apt install git zsh tzdata nodejs yarn -y


RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/mfaerevaag/wd.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/wd

curl -fsSL https://raw.githubusercontent.com/steven-shi/server-config/main/.zshrc -o ~/.zshrc


# ssh key
mkdir -p ~/.ssh
curl -fsSL https://raw.githubusercontent.com/steven-shi/server-config/main/id_rsa.pub -o ~/.ssh/authorized_keys

# nvim setup
sudo apt update
sudo apt install neovim -y
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cat << EOF > ~/.config/nvim/init.vim
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'elzr/vim-json'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

call plug#end()
EOF

nvim +PlugInstall +qall


chsh -s $(which zsh)
