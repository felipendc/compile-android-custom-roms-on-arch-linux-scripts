#!/bin/bash
# github.com/mamutal91

clear

prebuilts/misc/linux-x86/ccache/ccache -M 100G

export USE_CCACHE=1
export KBUILD_BUILD_USER=mamutal91
export KBUILD_BUILD_HOST=KrakenBox
export SELINUX_IGNORE_NEVERALLOWS=true
export KRAKEN_BUILD_TYPE=OFFICIAL

device=${1}

function ask() {
  echo
  echo -e "\n\e[31m\e[1m What do you want to do?\e[m"
  echo -e "\n\e[33m 1. ROM [enter]\e[m"
  echo -e "\e[32m 2. Settings\e[m"
  echo -e "\e[36m X. Anything\e[m"
  read answer
  case "$answer" in
    1|"") b=bacon ;;
    2) b=Settings ;;
    3) b=LineageParts ;;
    x|n|anything|Anything) ;;
    *) echo -e "\n\e[31m Invalid Answer!\e[m" ;;
  esac
  echo
}

ask

if [ -z $device ];then
  device=beryllium
else
  echo
fi

echo -e "\n\e[31m\e[1mBuild?\e[m"
echo -e "\n\e[33m 1. Compile Dirty [enter]\e[m"
echo -e "\e[36m 2. Clean and Clobber\e[m"
echo -e "\e[32m 3. Repo sync\e[m"
echo -e "\e[34m 4. Repo sync && Clean and Clobber\e[m"
read answer
case "$answer" in
  1|"")
  ;;
  2)
    echo "Cleaning builds..."
    make clobber && make clean
  ;;
  3)
    echo "Syncing source..."
    repo sync -c -j32 --force-sync
  ;;
  4)
    echo "Cleaning builds..."
    make clobber && make clean
    echo "Syncing source..."
    repo sync -c -j32 --force-sync
  ;;
  *)
    echo "Invalid answer..."
  ;;
esac
echo

function build() {
  . build/envsetup.sh
  lunch aosp_$device-userdebug
  make -j32 $b 2>&1 | tee log.txt
  sudo rm -rf /var/www/krakenproject.club/building/Kraken*
  cp -rf out/target/product/*/Kraken_*.* /var/www/krakenproject.club/building/
}

if [ -z $b ];then
  echo -e "End!"
else
  build
fi
