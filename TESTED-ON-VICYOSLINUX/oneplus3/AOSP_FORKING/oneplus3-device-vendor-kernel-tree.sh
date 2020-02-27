#!bin/bash

# For more information about this script, visit: github.com/felipendc   

###############################################################################################################
################## MAKE SURE TO MAKE THIS FILE EXECUTABLE TO PREVENT ANY PERMISSIONS ERRORS  ##################
###############################################################################################################


export aosp_dir="$HOME/AOSP-FORKING"

function sync () {
    cd $aosp_dir
    git lfs install
    sudo rm -r device/oneplus/oneplus3*
    git clone https://github.com/felipendc/android_device_oneplus_oneplus3.git -b lineage-17.1 device/oneplus/oneplus3
    sudo rm -r device/oneplus/oneplus3/.git

    sudo rm -r device/oppo/common*
    git clone https://github.com/felipendc/android_device_oppo_common.git -b lineage-17.1 device/oppo/common
    sudo rm -r device/oppo/common/.git

    sudo rm -r vendor/oneplus*
    git clone https://github.com/felipendc/proprietary_vendor_oneplus.git -b lineage-17.1 vendor/oneplus
    sudo rm -r vendor/oneplus/.git

    sudo rm -r kernel/oneplus/msm8996*
    git clone https://github.com/felipendc/android_kernel_oneplus_msm8996.git -b lineage-17.1 kernel/oneplus/msm8996
    sudo rm -r kernel/oneplus/msm8996/.git
    repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags --force-sync && opengapps
}


sync

