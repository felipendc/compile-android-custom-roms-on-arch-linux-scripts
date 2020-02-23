#!/bin/bash
# This script was only possible thanks to Alexandre Rangel "github.com/mamutal91"

# The script below is my modified version of Alexandre Rangel's 
# My github: github.com/felipendc

##################################################################################################
# An open source Git extension for versioning large files

# Git Large File Storage (LFS) replaces large files such as audio samples, videos, datasets, 
# and graphics with text pointers inside Git, 
# while storing the file contents on a remote server like GitHub.com or GitHub Enterprise.

# Form more information, visit: https://git-lfs.github.com/
##################################################################################################

aosp_dir="$HOME/AOSP-FORKING/"

cd $aosp_dir/vendor/opengapps/build && git lfs fetch --all && git lfs pull
cd $aosp_dir/vendor/opengapps/sources/all && git lfs fetch --all && git lfs pull
cd $aosp_dir/vendor/opengapps/sources/arm && git lfs fetch --all && git lfs pull
cd $aosp_dir/vendor/opengapps/sources/arm64 && git lfs fetch --all && git lfs pull
cd $aosp_dir/vendor/opengapps/sources/x86 && git lfs fetch --all && git lfs pull
cd $aosp_dir/vendor/opengapps/sources/x86_64 && git lfs fetch --all && git lfs pull

##########################################################################################
####### MAKE SURE TO MAKE THIS FILE EXECUTABLE TO PREVENT ANY PERMISSIONS ERRORS  ########
##########################################################################################

echo
echo "################################################################## "
tput setaf 2;echo "ALL DONE!!!";tput sgr0
echo "################################################################## "
echo
