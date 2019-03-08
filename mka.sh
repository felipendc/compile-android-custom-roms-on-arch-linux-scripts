#!/bin/bash
# github.com/mamutal91

clear

prebuilts/misc/linux-x86/ccache/ccache -M 100G

export USE_CCACHE=1
export KBUILD_BUILD_USER=mamutal91
export KBUILD_BUILD_HOST=KrakenBox
export SELINUX_IGNORE_NEVERALLOWS=true
export KRAKEN_BUILD_TYPE=OFFICIAL

function ask_device() {
  echo -e "\n\e[31m\e[1m Which device do you want to work?\e[m"
  echo -e "\n\e[33m 1. beryllium [enter]\e[m"
  echo -e "\e[32m 2. whyred\e[m"
  echo -e "\e[36m X. Anything\e[m"
  read answer
  case "$answer" in
    1|b|"") device=beryllium ;;
    2|w) device=whyred ;;
    x|n|a) ;;
    *) echo -e "\n\e[31m Invalid Answer!\e[m" ;;
  esac
}

function ask_rom() {
  echo -e "\n\e[31m\e[1m What do you want to do?\e[m"
  echo -e "\n\e[33m 1. KrakenProject [enter]\e[m"
  echo -e "\e[32m 2. ViperOS\e[m"
  echo -e "\e[36m X. Anything\e[m"
  read rom
  case "$rom" in
    1|"")
      rom=bacon
      lunch=aosp
      folder=Kraken
    ;;
    2)
      rom=poison
      lunch=viper
      folder=Viper
    ;;
    x|n|a) ;;
    *) echo -e "\n\e[31m Invalid Answer!\e[m" ;;
  esac
}

ask_device
ask_rom

echo -e "\n\e[31m\e[1mBuild?\e[m"
echo -e "\n\e[33m 1. Compile Dirty [enter]\e[m"
echo -e "\e[36m 2. Clean and Clobber\e[m"
echo -e "\e[32m 3. Repo sync\e[m"
echo -e "\e[34m 4. Repo sync && Clean and Clobber\e[m"
read answer
case "$answer" in
  1|"")
  compile=yes
  ;;
  2)
    echo -e "\e[34m Cleaning builds...\e[m"
    make clobber && make clean
  ;;
  3)
    echo -e "\e[34m Syncing source...\e[m"
    repo sync -c -j32 --force-sync
  ;;
  4)
    echo -e "\e[34m Cleaning builds...\e[m"
    make clobber && make clean
    echo -e "\e[34m Syncing source...\e[m"
    repo sync -c -j32 --force-sync
  ;;
  *) echo -e "\n\e[31m Invalid Answer!\e[m" ;;
esac

function build() {
  . build/envsetup.sh
  lunch $lunch_$device-userdebug
  make -j32 $b 2>&1 | tee log.txt
  sudo rm -rf /var/www/krakenproject.club/building/$folder/*
  cp -rf out/target/product/*/$folder_*.* /var/www/krakenproject.club/building/$folder/
}

if [ -z $compile ];then
  echo -e "End!"
else
  build
fi
