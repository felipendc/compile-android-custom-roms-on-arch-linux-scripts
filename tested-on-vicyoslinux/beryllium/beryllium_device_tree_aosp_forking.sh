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
}

sync