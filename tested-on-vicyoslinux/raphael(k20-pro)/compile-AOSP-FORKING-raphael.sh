#!/bin/bash

# github.com/TingyiChen
# github.com/felipendc

###############################################################################################################
################## MAKE SURE TO MAKE THIS FILE EXECUTABLE TO PREVENT ANY PERMISSIONS ERRORS  ##################
###############################################################################################################

export aosp_dir="$HOME/AOSP-FORKING"

function sync () {
    cd $aosp_dir
    git lfs install
    sudo rm -r device/xiaomi/raphael*
    git clone https://github.com/felipendc/aosp_device_xiaomi_raphael -b lineage-17.1 device/xiaomi/raphael
    sudo rm -r device/xiaomi/raphael/.git

    sudo rm -r vendor/xiaomi/raphael*
    git clone https://github.com/felipendc/vendor_xiaomi_raphael-1 -b ten vendor/xiaomi/raphael
    sudo rm -r vendor/xiaomi/raphael/.git

    sudo rm -r kernel/xiaomi/sm8150*
    git clone https://github.com/felipendc/kernel_xiaomi_sm8150 -b lineage-17.1 kernel/xiaomi/sm8150
    sudo rm -r kernel/xiaomi/sm8150/.git
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
    make clobber && make clean && . build/envsetup.sh && lunch aosp_raphael-userdebug && make -j$(nproc --all) bacon 2>&1 | tee log.txt
}

sync
lfs
compile
