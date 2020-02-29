#!/bin/bash

# Felipe Ndc "github.com/felipendc" 

###############################################################################################################
################## MAKE SURE TO MAKE THIS FILE EXECUTABLE TO PREVENT ANY PERMISSIONS ERRORS  ##################
###############################################################################################################

# ConfigPanel removed, for now.

export titanium="$HOME/titanium"

function sync () {
    cd $titanium
    
    sudo rm -r device/oneplus/oneplus3*
    git clone https://github.com/felipendc/titanium_device_oneplus_oneplus3 -b lineage-17.1 device/oneplus/oneplus3
    sudo rm -r device/oneplus/oneplus3/.git

    sudo rm -r device/oppo/common*
    git clone https://github.com/felipendc/titanium_device_oppo_common -b lineage-17.1 device/oppo/common
    sudo rm -r device/oppo/common/.git

    sudo rm -r vendor/oneplus*
    git clone https://github.com/felipendc/proprietary_vendor_oneplus.git -b lineage-17.1 vendor/oneplus
    sudo rm -r vendor/oneplus/.git

    sudo rm -r kernel/oneplus/msm8996*
    git clone https://github.com/felipendc/android_kernel_oneplus_msm8996.git -b lineage-17.1 kernel/oneplus/msm8996
    sudo rm -r kernel/oneplus/msm8996/.git

    make clobber && make clean && . build/envsetup.sh && lunch titanium_oneplus3-userdebug && make -j$(nproc --all) titanium 2>&1 | tee log.txt
}

sync

