#!/bin/bash

# github.com/TingyiChen
# github.com/felipendc

###############################################################################################################
################## MAKE SURE TO MAKE THIS FILE EXECUTABLE TO PREVENT ANY PERMISSIONS ERRORS  ##################
###############################################################################################################
#    sudo rm -r kernel/xiaomi/sm8150*
#    git clone https://github.com/felipendc/kernel_xiaomi_sm8150 -b lineage-17.1 kernel/xiaomi/sm8150
#    sudo rm -r kernel/xiaomi/sm8150/.git

#    sudo rm -r kernel/xiaomi/sm8150*
#    git clone https://github.com/UtsavBalar1231/kernel_xiaomi_raphael -b master kernel/xiaomi/sm8150
#    sudo rm -r kernel/xiaomi/sm8150/.git

export aosp_dir="$HOME/AOSP-FORKING"

function sync () {
    cd $aosp_dir
    git lfs install

    sudo rm -r device/xiaomi/raphael*
    git clone https://github.com/felipendc/device_xiaomi_raphael -b ten device/xiaomi/raphael
    sudo rm -r device/xiaomi/raphael/.git

    sudo rm -r vendor/xiaomi*
    git clone https://github.com/felipendc/vendor_xiaomi_raphael -b ten vendor/xiaomi
    sudo rm -r vendor/xiaomi/raphael/.git

    sudo rm -r kernel/xiaomi/sm8150*
    git clone https://github.com/felipendc/kernel_xiaomi_raphael -b ten kernel/xiaomi/raphael
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
