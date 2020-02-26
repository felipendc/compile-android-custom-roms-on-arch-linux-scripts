#!/bin/bash

# This script was only possible thanks to Felipe Ndc "github.com/felipendc" 

###############################################################################################################
################## MAKE SURE TO MAKE THIS FILE EXECUTABLE TO PREVENT ANY PERMISSIONS ERRORS  ##################
###############################################################################################################


export aosp_dir="$HOME/AOSP-FORKING"

function sync () {
    cd $aosp_dir
    git lfs install
    sudo rm -r device/xiaomi/beryllium*
    git clone https://github.com/mamutal91/device_xiaomi_beryllium -b ten device/xiaomi/beryllium
    sudo rm -r device/xiaomi/beryllium/.git
    sudo rm -r device/xiaomi/sdm845-common*
    git clone https://github.com/mamutal91/device_xiaomi_sdm845-common -b ten device/xiaomi/sdm845-common
    sudo rm -r device/xiaomi/sdm845-common/.git
    sudo rm -r kernel/xiaomi/sdm845*
    git clone https://github.com/LineageOS/android_kernel_xiaomi_sdm845 -b lineage-17.1 kernel/xiaomi/sdm845
    sudo rm -r kernel/xiaomi/sdm845/.git
#    sudo rm -r kernel/xiaomi/sdm845*
#    git clone https://github.com/LineageOS/android_kernel_xiaomi_sdm845 -b lineage-17.0 kernel/xiaomi/sdm845
#    sudo rm -r kernel/xiaomi/sdm845/.git
    repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags --force-sync && opengapps
}

function lfs () {
    cd $aosp_dir/vendor/opengapps/build && git lfs fetch --all && git lfs pull
    cd $aosp_dir/vendor/opengapps/sources/all && git lfs fetch --all && git lfs pull
    cd $aosp_dir/vendor/opengapps/sources/arm && git lfs fetch --all && git lfs pull
    cd $aosp_dir/vendor/opengapps/sources/arm64 && git lfs fetch --all && git lfs pull
    cd $aosp_dir/vendor/opengapps/sources/x86 && git lfs fetch --all && git lfs pull
    cd $aosp_dir/vendor/opengapps/sources/x86_64 && git lfs fetch --all && git lfs pull
}

function compile () {
    cd $aosp_dir
    make clobber && make clean && . build/envsetup.sh && lunch aosp_beryllium-userdebug && make -j$(nproc --all) bacon 2>&1 | tee log.txt
}

sync
lfs
compile