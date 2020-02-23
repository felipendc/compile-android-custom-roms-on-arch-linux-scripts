# This script was only possible thanks to felipendc "github.com/felipendc"
# For more information about this script, visit: github.com/felipendc   


# My personal Linux Distribution: VicyosLinux (Based on Arch)

# GDRIVE: https://drive.google.com/drive/folders/1JyI8O4DhJb9ktIaffiJYu966r9OIUwQI
# Or, if you will... you can also build it from the source: https://github.com/felipendc/vicyos-build


git clone https://github.com/felipendc/android_device_oneplus_oneplus3.git -b lineage-17.1 device/oneplus/oneplus3
git clone https://github.com/felipendc/android_device_oppo_common.git -b lineage-17.1 device/oppo/common
git clone https://github.com/felipendc/proprietary_vendor_oneplus.git -b lineage-17.1 vendor/oneplus
git clone https://github.com/felipendc/android_kernel_oneplus_msm8996.git -b lineage-17.1 kernel/oneplus/msm8996

###############################################################
#################### FOR AOSP CUSTOM ROMS  ####################
###############################################################
# . build/envsetup.sh or  source build/envsetup.sh
# lunch aosp_oneplus3
# make -j$(nproc --all) bacon
# For detailed logs, use:
# make -j$(nproc --all) bacon 2>&1 | tee log.txt
# Remember to make clobber && make clean every now and then!
###############################################################

 

