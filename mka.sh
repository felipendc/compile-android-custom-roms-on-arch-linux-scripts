#!/bin/bash
# github.com/mamutal91

clear

dir=($pwd)

if [ "$dir" == "/home/mamutal91/viper" ]; then
  prebuilts/misc/linux-x86/ccache/ccache -M 100G
else
  echo ""
fi

export USE_CCACHE=1
export KBUILD_BUILD_USER=mamutal91
export KBUILD_BUILD_HOST=MamutBox
export SELINUX_IGNORE_NEVERALLOWS=true
export KRAKEN_BUILD_TYPE=OFFICIAL
export VIPER_BUILD_TYPE=OFFICIAL

function ask_device() {
  echo -e "\n\e[31m\e[1m ## Which device do you want to work?\e[m"
  echo -e "\n\e[33m 1. beryllium [enter]\e[m"
  echo -e "\e[32m 2. whyred\e[m"
  echo -e "\n\e[36m X. Nothing\e[m"
  read answer
  case "$answer" in
    1|b|"") device=beryllium ;;
    2|w) device=whyred ;;
    x|n|a) ;;
    *) echo -e "\n\e[31m Invalid Answer!\e[m" ;;
  esac
}

function ask_branch() {
  echo -e "\e[31m\e[1m ## Which branch do you want to work on?\e[m"
  echo -e "\n\e[32m 1. ten [enter]\e[m"
  echo -e "\e[34m 2. pie\e[m"
  read branch
  case "$branch" in
    1|"") branch_kk="ten" ;;
    2) branch_kk="pie" ;;
    *) echo -e "\n\e[31m Invalid Answer!\e[m" ;;
  esac
}

function ask_rom() {
  echo -e "\n\e[31m\e[1m ## What do you want to do?\e[m"
  echo -e "\n\e[33m 1. KrakenProject [enter]\e[m"
  echo -e "\e[32m 2. ViperOS\e[m"
  echo -e "\n\e[36m X. Nothing\e[m"
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
ask_branch

function clone_tree_kraken() {
  echo -e "\n\e[31m\e[1m ## Clone KERNELS?\e[m"
  echo -e "\n\e[33m 1. Yes\e[m"
  echo -e "\e[36m 2. No\e[m"
  read clone_kernels
  case "$clone_kernels" in
    1|y) kernels=yes ;;
    2|n|"") ;;
  esac

  echo -e "\n\e[31m\e[1m ## Clone VENDORS?\e[m"
  echo -e "\n\e[33m 1. Yes\e[m"
  echo -e "\e[36m 2. No\e[m"
  read clone_vendors
  case "$clone_vendors" in
    1|y) vendors=yes ;;
    2|n|"") ;;
  esac

  rm -rf device/xiaomi/beryllium
  git clone ssh://git@github.com/KrakenDevices/device_xiaomi_beryllium -b $branch_kk device/xiaomi/beryllium

  rm -rf device/xiaomi/sdm845-common
  git clone ssh://git@github.com/KrakenDevices/device_xiaomi_sdm845-common -b $branch_kk device/xiaomi/sdm845-common

  rm -rf device/xiaomi/whyred
  git clone ssh://git@github.com/KrakenDevices/device_xiaomi_whyred -b $branch_kk device/xiaomi/whyred

  function kernels() {
    rm -rf kernel/xiaomi/sdm845
    git clone https://github.com/akhilnarang/beryllium -b $branch_kk kernel/xiaomi/sdm845
    rm -rf kernel/xiaomi/sdm660
    git clone https://github.com/akhilnarang/whyred -b $branch_kk kernel/xiaomi/sdm660
  }

  function vendors() {
    rm -rf vendor/xiaomi
    git clone https://gitlab.com/TeamIllusion/proprietary_vendor_xiaomi -b $branch_kk vendor/xiaomi
    rm -rf vendor/xiaomi/{aries,armani,cancro,capricorn,chiron,dipper,equuleus,ferrari,gemini,hydrogen,ido,jasmine_sprout,jason,kenzo,land,libra,lithium,mido,msm*,natrium,polaris,sagit,santoni,scorpio,tissot,wayne*}
  }

  if [ -z $kernels ];then
    echo -e ""
  else
    kernels
  fi

  if [ -z $vendors ];then
    echo -e ""
  else
    vendors
  fi
}

function clone_tree_viper() {
  echo -e "\n\e[31m\e[1m ## Clone KERNELS?\e[m"
  echo -e "\n\e[33m 1. Yes\e[m"
  echo -e "\e[36m 2. No\e[m"
  read clone_kernels
  case "$clone_kernels" in
    1|y) kernels=yes ;;
    2|n|"") ;;
  esac

  echo -e "\n\e[31m\e[1m ## Clone VENDORS?\e[m"
  echo -e "\n\e[33m 1. Yes\e[m"
  echo -e "\e[36m 2. No\e[m"
  read clone_vendors
  case "$clone_vendors" in
    1|y) vendors=yes ;;
    2|n|"") ;;
  esac

  echo -e "\n\e[31m\e[1m ## Clone CLANG?\e[m"
  echo -e "\n\e[33m 1. Yes\e[m"
  echo -e "\e[36m 2. No\e[m"
  read clone_clang
  case "$clone_clang" in
    1|y) clang=yes ;;
    2|n|"") ;;
  esac

  rm -rf device/xiaomi/beryllium
  git clone ssh://git@github.com/Viper-Devices/android_device_xiaomi_beryllium -b $branch_kk device/xiaomi/beryllium

  rm -rf device/xiaomi/sdm845-common
  git clone ssh://git@github.com/Viper-Devices/android_device_xiaomi_sdm845-common -b $branch_kk device/xiaomi/sdm845-common

  function kernels() {
    rm -rf kernel/xiaomi/sdm845
    git clone https://github.com/akhilnarang/beryllium -b $branch_kk kernel/xiaomi/sdm845
  }

  function vendors() {
    rm -rf vendor/xiaomi
    git clone https://gitlab.com/TeamIllusion/proprietary_vendor_xiaomi -b $branch_kk vendor/xiaomi
    rm -rf vendor/xiaomi/{aries,armani,cancro,capricorn,chiron,dipper,equuleus,ferrari,gemini,hydrogen,ido,jasmine_sprout,jason,kenzo,land,libra,lithium,mido,msm*,natrium,polaris,sagit,santoni,scorpio,tissot,wayne*,whyred}
  }

  function clang() {
    rm -rf prebuilts/clang/host/linux-x86
    git clone ssh://git@github.com/KrakenProject/prebuilts_clang_host_linux-x86 -b $branch_kk prebuilts/clang/host/linux-x86
  }

  if [ -z $kernels ];then
    echo -e ""
  else
    kernels
  fi

  if [ -z $vendors ];then
    echo -e ""
  else
    vendors
  fi

  if [ -z $clang ];then
    echo -e ""
  else
    clang
  fi
}

function ask_tree() {
  echo -e "\n\e[31m\e[1m ## Clone tree?\e[m"
  echo -e "\n\e[33m 1. No [enter]\e[m"
  echo -e "\e[32m 2. Clone tree KrakenProject (beryllium/whyred)\e[m"
  echo -e "\e[36m 3. Clone tree ViperOS (beryllium)\e[m"
  read ask_tree
  case "$ask_tree" in
    1|"") ;;
    2) ask_tree_kraken=yes ;;
    3) ask_tree_viper=yes ;;
    *) echo -e "\n\e[31m Invalid Answer!\e[m" ;;
  esac
}

ask_tree

echo -e "\n\e[31m\e[1m ## Build?\e[m"
echo -e "\n\e[33m 1. Compile Dirty [enter]\e[m"
echo -e "\e[36m 2. Clean and Clobber\e[m"
echo -e "\e[32m 3. Repo sync\e[m"
echo -e "\e[34m 4. Repo sync && Clean and Clobber\e[m"
echo -e "\n\e[36m X. Nothing\e[m"
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
  x|n|a) ;;
  *) echo -e "\n\e[31m Invalid Answer!\e[m" ;;
esac

function build() {
  . build/envsetup.sh

  if [ $lunch == "aosp" ];then
    lunch aosp_$device-userdebug
  else
    lunch viper_$device-userdebug
  fi

  make -j32 $rom 2>&1 | tee log.txt

  sudo rm -rf /var/www/krakenproject.club/building/$folder/*
  cp -rf out/target/product/*/$folder_*.* /var/www/krakenproject.club/building/$folder/
}

if [ -z $ask_tree_kraken ];then
  echo -e ""
else
  clone_tree_kraken
fi

if [ -z $ask_tree_viper ];then
  echo -e ""
else
  clone_tree_viper
fi

if [ -z $compile ];then

  echo -e "\n\e[31m End, you chose not to compile now.\e[m"
else
  build
fi
