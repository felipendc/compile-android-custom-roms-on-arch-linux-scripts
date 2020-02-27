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
    make clobber && make clean && . build/envsetup.sh && lunch aosp_oneplus3-userdebug && make -j$(nproc --all) bacon 2>&1 | tee log.txt
}

sync
lfs
compile
