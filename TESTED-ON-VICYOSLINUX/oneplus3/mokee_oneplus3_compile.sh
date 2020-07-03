#!/bin/bash

function compile (){
repo init -u https://github.com/MoKee/android.git -b mkq-mr1
repo sync
rm -r out
. build/envsetup.sh
lunch mokee_oneplus3-userdebug
mka bacon 
}

compile