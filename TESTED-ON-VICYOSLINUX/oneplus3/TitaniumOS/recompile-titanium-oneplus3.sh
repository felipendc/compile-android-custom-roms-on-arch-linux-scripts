#!/bin/bash

# Felipe Ndc "github.com/felipendc" 

###############################################################################################################
################## MAKE SURE TO MAKE THIS FILE EXECUTABLE TO PREVENT ANY PERMISSIONS ERRORS  ##################
###############################################################################################################


export titanium="$HOME/titanium"

function sync () {
    cd $titanium

    repo sync -j$(nproc --all) --force-sync -c --no-clone-bundle --no-tags --optimized-fetch --prune
}

function compile () {
    cd $titanium
    make clobber && make clean && . build/envsetup.sh && lunch titanium_oneplus3-userdebug && make -j$(nproc --all) titanium 2>&1 | tee log.txt
}

#sync
compile
