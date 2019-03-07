#!/bin/bash
# github.com/mamutal91

clear

prebuilts/misc/linux-x86/ccache/ccache -M 50G

export USE_CCACHE=1
export KBUILD_BUILD_USER=mamutal91
export KBUILD_BUILD_HOST=KrakenBox
export SELINUX_IGNORE_NEVERALLOWS=true
export KRAKEN_BUILD_TYPE=OFFICIAL

device=${1}

function clone_tree() {
    rm -rf device/xiaomi/whyred
    git clone ssh://git@github.com/KrakenDevices/device_xiaomi_whyred.git -b android-9.0 device/xiaomi/whyred
    rm -rf device/xiaomi/beryllium
    git clone ssh://git@github.com/KrakenDevices/device_xiaomi_beryllium.git -b android-9.0 device/xiaomi/beryllium
    rm -rf device/xiaomi/sdm845-common
    git clone ssh://git@github.com/KrakenDevices/device_xiaomi_sdm845-common.git -b android-9.0 device/xiaomi/sdm845-common

    rm -rf kernel/xiaomi/sdm845
    git clone https://github.com/akhilnarang/beryllium.git -b pie kernel/xiaomi/sdm845
    rm -rf kernel/xiaomi/sdm660
    git clone https://github.com/akhilnarang/whyred.git -b pie kernel/xiaomi/sdm660
    rm -rf vendor/MiuiCamera
    git clone https://github.com/PixelExperience-Devices/vendor_MiuiCamera.git -b pie-whyred vendor/MiuiCamera
    rm -rf vendor/xiaomi
    git clone https://gitlab.com/TeamIllusion/proprietary_vendor_xiaomi.git -b pie vendor/xiaomi
}

function ask() {
  echo
  echo -e "What do you want to do?"
  echo -e "----------------------"
  echo
  echo -e "     1. ROM [enter]"
  echo -e "     2. Settings"
  echo
  echo -e "     --------------------"
  echo -e "     T. Clone tree beryllium"
  echo -e "     X. Anything"
  echo
  echo -n "Answer: "
  read answer
  case "$answer" in
    1|"")
      b=bacon
    ;;
    2)
      b=Settings
    ;;
    3)
      b=LineageParts
    ;;
    t|T|tree)
      echo "Cloning tree..."
      clone_tree
      b=bacon
    ;;
    x|n|anything|Anything)
    ;;
    *)
      echo "Invalid answer..."
    ;;
  esac
  echo
}

ask

if [ -z $device ];then
  device=beryllium
else
  echo
fi

echo
echo -e "Build?"
echo -e "-----------------------------"
echo
echo -e "     1. Compile Dirty [enter]"
echo -e "     2. Clean and Clobber"
echo -e "     3. Repo sync"
echo -e "     4. Repo sync && Clean and Clobber"
echo
echo -n "Answer: "
read answer
case "$answer" in
  1|"")
  ;;
  2)
    echo
    echo "Cleaning builds..."
    make clobber && make clean
  ;;
  3)
    echo
    echo "Syncing source..."
    repo sync -c -j32 --force-sync
  ;;
  4)
    echo
    echo "Cleaning builds..."
    make clobber && make clean
    echo
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

