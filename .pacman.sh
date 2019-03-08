#!/bin/bash
# github.com/mamutal91

echo "Updating Pacman and AUR"
    sudo pacman -Syyu --noconfirm
    yay -Syyu --noconfirm

echo "Removing packages not used"
    sudo pacman -Qdtq --noconfirm
    yay -Qdtq --noconfirm
    sudo pacman -Rncs $(pacman -Qdtq) --noconfirm
    yay -Rncs $(yay -Qdtq) --noconfirm
