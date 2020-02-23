#!/bin/bash
# This script was only possible thanks to Alexandre Rangel "github.com/mamutal91"

# My github: github.com/felipendc

##################################################################################################
# An open source Git extension for versioning large files

# Git Large File Storage (LFS) replaces large files such as audio samples, videos, datasets, 
# and graphics with text pointers inside Git, 
# while storing the file contents on a remote server like GitHub.com or GitHub Enterprise.

# Form more information, visit: https://git-lfs.github.com/
##################################################################################################

export aosp_dir="/home/vicyos/AOSP-FORKING/"

function opengapps () {
  pwd_opengapps=$(pwd)
  cd $aosp_dir/vendor/opengapps/build && git lfs fetch --all && git lfs pull
  cd $aosp_dir/vendor/opengapps/sources/all && git lfs fetch --all && git lfs pull
  cd $aosp_dir/vendor/opengapps/sources/arm && git lfs fetch --all && git lfs pull
  cd $aosp_dir/vendor/opengapps/sources/arm64 && git lfs fetch --all && git lfs pull
  cd $aosp_dir/vendor/opengapps/sources/x86 && git lfs fetch --all && git lfs pull
  cd $aosp_dir/vendor/opengapps/sources/x86_64 && git lfs fetch --all && git lfs pull
  cd $pwd_opengapps
}
