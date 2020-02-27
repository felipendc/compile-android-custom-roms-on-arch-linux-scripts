#!/bin/bash

# github.com/TingyiChen
# github.com/felipendc

###############################################################################################################
################## MAKE SURE TO MAKE THIS FILE EXECUTABLE TO PREVENT ANY PERMISSIONS ERRORS  ##################
###############################################################################################################

export aosp_dir="$HOME/AOSP-FORKING"

function sync () {
    cd $aosp_dir
    repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags --force-sync && opengapps
    
    sudo rm -r device/xiaomi/raphael*
    git clone https://github.com/felipendc/aosp_xiaomi_raphael -b ten device/xiaomi/raphael
    sudo rm -r device/xiaomi/raphael/.git

    sudo rm -r vendor/xiaomi/raphael*
    git clone https://github.com/felipendc/proprietary_vendor_xiaomi -b ten vendor/xiaomi
    sudo rm -r vendor/xiaomi/raphael/.git

    sudo rm -r kernel/xiaomi/sm8150*
    git clone https://github.com/felipendc/kernel_xiaomi_sm8150 -b lineage-17.1 kernel/xiaomi/sm8150
}

sync