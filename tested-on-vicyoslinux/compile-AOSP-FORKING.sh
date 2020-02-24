#!/bin/bash

# This script was only possible thanks to Felipe Ndc "github.com/felipendc" 


aosp_dir="$HOME/AOSP-FORKING"


cd $aosp_dir/vendor/opengapps/build && git lfs fetch --all && git lfs pull
cd $aosp_dir/vendor/opengapps/sources/all && git lfs fetch --all && git lfs pull
cd $aosp_dir/vendor/opengapps/sources/arm && git lfs fetch --all && git lfs pull
cd $aosp_dir/vendor/opengapps/sources/arm64 && git lfs fetch --all && git lfs pull
cd $aosp_dir/vendor/opengapps/sources/x86 && git lfs fetch --all && git lfs pull
cd $aosp_dir/vendor/opengapps/sources/x86_64 && git lfs fetch --all && git lfs pull

cd $aosp_dir/repo sync --force-sync && opengapps && make clobber && make clean && . build/envsetup.sh && lunch aosp_oneplus3-userdebug && make -j$(nproc --all) bacon 2>&1 | tee log.txt
