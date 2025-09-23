#!/bin/bash

sudo pacman -S --needed --noconfirm git base-devel

if [ -d ~/.dotfiles ]; then
    echo "Dotfiles directory already exists"
else
    echo "Cloning dotfiles"
    git clone "https://github.com/https123456789/system" "~/.dotfiles"
fi

sudo pacman -S --needed --noconfirm nushell

nu init.nu
