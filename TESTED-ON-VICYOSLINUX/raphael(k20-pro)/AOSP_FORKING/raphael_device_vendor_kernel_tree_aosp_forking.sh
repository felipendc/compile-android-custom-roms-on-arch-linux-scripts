#!/bin/bash

# github.com/TingyiChen
# github.com/felipendc

###############################################################################################################
################## MAKE SURE TO MAKE THIS FILE EXECUTABLE TO PREVENT ANY PERMISSIONS ERRORS  ##################
###############################################################################################################

export aosp_dir="$HOME/AOSP-FORKING"

function sync () {
    cd $aosp_dir
    sudo rm -r device/xiaomi/raphael*
    git clone https://github.com/felipendc/device_xiaomi_raphael -b ten device/xiaomi/raphael
    sudo rm -r device/xiaomi/raphael/.git

    sudo rm -r vendor/xiaomi*
    git clone https://github.com/nullxception/vendor_xiaomi_raphael -b ten vendor/xiaomi
    sudo rm -r vendor/xiaomi/raphael/.git

    sudo rm -r kernel/xiaomi/sm8150*
    git clone https://github.com/felipendc/kernel_xiaomi_raphael -b ten kernel/xiaomi/raphael
    sudo rm -r kernel/xiaomi/sm8150/.git

    repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags --force-sync && opengapps
}

sync