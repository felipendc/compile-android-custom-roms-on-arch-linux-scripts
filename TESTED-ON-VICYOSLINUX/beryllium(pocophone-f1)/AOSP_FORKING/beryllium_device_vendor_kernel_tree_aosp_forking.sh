#!/bin/bash

# This script was only possible thanks to Felipe Ndc "github.com/felipendc" 

###############################################################################################################
################## MAKE SURE TO MAKE THIS FILE EXECUTABLE TO PREVENT ANY PERMISSIONS ERRORS  ##################
###############################################################################################################

export aosp_dir="$HOME/AOSP-FORKING"

function sync () {
    cd $aosp_dir
    sudo rm -r device/xiaomi/beryllium*
    git clone https://github.com/felipendc/aosp_xiaomi_beryllium -b ten device/xiaomi/beryllium
    sudo rm -r device/xiaomi/beryllium/.git

    sudo rm -r device/xiaomi/sdm845-common*
    git clone https://github.com/felipendc/android_device_xiaomi_sdm845-common -b lineage-17.1 device/xiaomi/sdm845-common
    sudo rm -r device/xiaomi/sdm845-common/.git

    sudo rm -r kernel/xiaomi/sdm845*
    git clone https://github.com/felipendc/kernel_xiaomi_sdm845 -b ten kernel/xiaomi/sdm845
    sudo rm -r kernel/xiaomi/sdm845/.git

    sudo rm -r vendor/xiaomi/beryllium*
    git clone https://github.com/felipendc/proprietary_vendor_xiaomi_beryllium -b ten vendor/xiaomi/beryllium
    sudo rm -r vendor/xiaomi/beryllium/.git

    repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags --force-sync && opengapps
}

sync