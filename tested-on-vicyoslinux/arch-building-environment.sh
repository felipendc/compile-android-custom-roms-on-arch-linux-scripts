#!/bin/bash
# This script was only possible thanks to Alexandre Rangel "github.com/mamutal91"

# For more information about this script, visit: github.com/felipendc   
#
# My personal Linux Distribution: VicyosLinux (Based on Arch)
# GDRIVE: https://drive.google.com/drive/folders/1JyI8O4DhJb9ktIaffiJYu966r9OIUwQI
# Or, if you will... you can also build it from the source: https://github.com/felipendc/vicyos-build


export TERM=xterm-256color

sudo rm /var/lib/pacman/db.lck

sudo pacman -S reflector --noconfirm
sudo reflector -l 10 --sort rate --save /etc/pacman.d/mirrorlist

function pacman(){
  sudo pacman -Sy base-devel go git repo wget ccache imagemagick cronie ntp lzip nginx --needed --noconfirm
# No need to download these: zsh "zsh-syntax-highlighting" packages for now, because I've already have them install on my VicyosLinux.
}

function trizen-install(){
  rm -rf trizen
  git clone https://aur.archlinux.org/trizen-git.git
  cd trizen-git
  makepkg -si --noconfirm
  cd ..
  rm -rf trizen-git
}

function yay-install(){
  rm -rf yay
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
}


trizen -S lib32-gconf --needed --noconfirm
trizen -S lib32-js17 --needed --noconfirm
trizen -S lib32-gcc-libs --needed --noconfirm
trizen -S git-lfs --needed --noconfirm

# Run it for each time you compile a new rom!
git lfs install


readonly PACMAN_CLOUD=(
  lib32-ncurses lib32-libxml2 lib32-libcroco lib32-libsoup lib32-llvm-libs lib32-readline lib32-librsvg lib32-mesa lib32-rest lib32-cairo
  lib32-glew1.10 lib32-gtk3 lib32-polkit lib32-colord lib32-gtk2 lib32-pango lib32-libdbusmenu-gtk2 lib32-libindicator-gtk2 lib32-libappindicator-gtk2)

readonly AUR_CLOUD=(
  gnupg flex bison gperf sdl wxgtk squashfs-tools curl ncurses zlib schedtool perl-switch zip unzip libxslt python2-virtualenv bc gcc-multilib lib32-zlib
  rsync lib32-ncurses5-compat-libs lib32-readline make pngcrush pngquant)

function pacman-cloud(){
  for i in "${PACMAN_CLOUD[@]}"; do
    sudo pacman -S ${i} --needed --noconfirm
  done
}

function aur-cloud(){
  for i in "${AUR_CLOUD[@]}"; do
    yay -S ${i} --needed --noconfirm
  done
}

function bin(){
  rm -rf ~/.bin
  mkdir ~/.bin
  PATH=~/.bin:$PATH
  curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
  sudo chmod a+x ~/.bin/repo
}

function symlinksdk(){
  rm -rf android* .android*
  wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
  tar -xvzf android-sdk_r24.4.1-linux.tgz
  mv android-sdk-linux .android-sdk
  rm -rf android-sdk_r24.4.1-linux.tgz
  ln -s /usr/bin/make-3.81 ~/.bin/make
  ln -s /usr/bin/make-3.81-config ~/.bin/make-config
  ln -s /usr/bin/python2 ~/.bin/python
  ln -s /usr/bin/python2-config ~/.bin/python-config
  gpg --keyserver pgp.mit.edu --recv-keys C52048C0C0748FEE227D47A2702353E0F7E48EDB
  yay -S ncurses5-compat-libs --needed --noconfirm
}

function java(){
  yay -S jdk8-openjdk --needed --noconfirm
  sudo archlinux-java set java-8-openjdk
}

function hour(){
  sudo ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
}

function config_system(){
  sudo systemctl enable cronie
  sudo systemctl enable ntpd
  sudo chown -R $USER:$USER /home/$USER
  chmod +x /home/$USER
}
#############################################################################################################
## No need to download zsh because I've already have my own modified zsh.
#function zsh(){
#  rm -rf $HOME/.oh-my-zsh
#  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
#  rm -rf .zshrc
#  wget https://raw.githubusercontent.com/mamutal91/buildroid/master/home/.zshrc
#}
#############################################################################################################

pacman
yay-install
pacman-cloud
aur-cloud
bin
symlinksdk
java
hour
config_system
zsh

#rm -rf android*
