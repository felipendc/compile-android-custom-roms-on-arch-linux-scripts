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
    git clone https://github.com/felipendc/aosp_device_xiaomi_raphael -b lineage-17.1 device/xiaomi/raphael
    sudo rm -r device/xiaomi/raphael/.git

    sudo rm -r vendor/xiaomi/raphael*
    git clone https://github.com/felipendc/vendor_xiaomi_raphael-1 -b ten vendor/xiaomi/raphael
    sudo rm -r vendor/xiaomi/raphael/.git

    sudo rm -r kernel/xiaomi/sm8150*
    git clone https://github.com/felipendc/kernel_xiaomi_sm8150 -b lineage-17.1 kernel/xiaomi/sm8150
    sudo rm -r kernel/xiaomi/sm8150/.git
}

sync