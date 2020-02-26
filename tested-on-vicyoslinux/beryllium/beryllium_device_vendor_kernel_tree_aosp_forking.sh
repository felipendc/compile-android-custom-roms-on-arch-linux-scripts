#!/bin/bash

# This script was only possible thanks to Felipe Ndc "github.com/felipendc" 

###############################################################################################################
################## MAKE SURE TO MAKE THIS FILE EXECUTABLE TO PREVENT ANY PERMISSIONS ERRORS  ##################
###############################################################################################################

export aosp_dir="$HOME/AOSP-FORKING"

function sync () {
    cd $aosp_dir
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
}

sync