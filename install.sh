#! /bin/bash

echo "Install packages..."

# TODO: prompt to install packages
# . ./scripts/getpkgs.sh

echo "Creating symlinks..."
echo "  .bashrc..."
ln -s $PWD/bash/bashrc $HOME/.bashrc
echo "  .gitdonfig..."
ln -s $PWD/git/gitconfig $HOME/.gitconfig

echo "  .config/tmux/tmux.conf..."
mkdir $HOME/.config/tmux
ln -s $PWD/tmux/tmux.conf $HOME/.config/tmux/tmux.conf

echo "  .config/nvim/..."
ln -s $PWD/nvim/ $HOME/.config/nvim

echo "Install tpm (tmux plugin manager)..."
mkdir $HOME/.config/tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm

# source bashrc
source ~/.bashrc
