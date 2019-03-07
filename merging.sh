#!/bin/bash
# github.com/mamutal91

# rm -rf merging.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/merging.sh && chmod +x merging.sh && ./merging.sh

clear

date=$(date +"%Y%m%d-%H%M")
tmp=/home/mamutal91/merging_tmp_$date/
mkdir -p $tmp

function ask_branch() {
  echo -e "\e[31m\e[1m Which branch do you want to work on?\e[m"
  echo -e "\n\e[32m 1. android-10.0 / lineage-17.0\e[m"
  echo -e "\e[34m 2. android-9.0 / lineage-16.0\e[m"
  read branch
  case "$branch" in
    1|"") branch_kk="android-10.0" ; branch_los="lineage-17.0" ;;
    2) branch_kk="android-9.0" ; branch_los="lineage-16.0" ;;
    *) echo -e "\n\e[31m Invalid Answer!\e[m" ;;
  esac
  echo -e "\n\e[1m\e[3m Ok! You will work with branchs \e[31m\e[1m$branch_kk\e[m / \e[31m\e[1m$branch_los\e[m"
}

function ask_action() {
  echo -e "\n\e[31m\e[1m What do you want to do\e[m"
  echo -e "\n\e[33m 1. Sync repositories \e[4m@KrakenProject\e[m\e[33m with \e[4m@mamutal91\e[m"
  echo -e "\e[36m 2. Pull rebase Lineage\e[m"
  echo -e "\e[32m 3. Update tree (beryllium/whyred)\e[m"
  echo -e "\e[34m 4. Merge tag AOSP\e[m"
  echo -e "\e[34m 5. Create BACKUP branch\e[m"
  echo -e "\e[36m 6. Remove BACKUP branch\e[m"
  read action
  case "$action" in
    1|"")  action="mamutal91" ;;
    2)  action="lineage" ;;
    3)  action="tree" ;;
    4)  action="aosp" ;;
    5)  action="create_backup" ;;
    6)  action="remove_backup" ;;
  esac
  echo -e "\n\e[1m\e[3m Ok! Selected: \e[31m\e[1m$action\e[m"
}

ask_branch
ask_action

readonly repos=(
  build
  build_soong
  device_custom_sepolicy
  device_qcom_sepolicy
  device_qcom_sepolicy-legacy
  kraken-sdk
  packages_apps_Bluetooth
  packages_apps_CustomParts
  packages_apps_DocumentsUI
  packages_apps_Launcher3
  packages_apps_Settings
  packages_apps_Updater
  packages_overlays_Custom
  vendor_aosp
  frameworks_base
  prebuilts_clang_host_linux-x86
)

readonly repostree=(
  device_xiaomi_whyred
  device_xiaomi_beryllium
  device_xiaomi_sdm845-common
)

function mamutal91() {
  for i in "${repos[@]}"; do
    repo=${i}
    cd $tmp && rm -rf $repo
    git clone ssh://git@github.com/mamutal91/${i} -b $branch_kk
    cd $repo
    echo && git push ssh://git@github.com/KrakenProject/$repo HEAD:refs/heads/$branch_kk --force
    echo -e "\n\e[33m------------------------------------------------------\e[m"
  done
}

function lineage() {
  cd $tmp
  git clone ssh://git@github.com/mamutal91/build -b $branch_kk && cd build
  git pull --rebase https://github.com/LineageOS/android_build -t $branch_los
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/build HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/build_soong -b $branch_kk && cd build_soong
  git pull --rebase https://github.com/LineageOS/android_build_soong -t $branch_los
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/build_soong HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/device_custom_sepolicy -b $branch_kk && cd device_custom_sepolicy
  git pull --rebase https://github.com/LineageOS/android_device_lineage_sepolicy -t $branch_los
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/device_custom_sepolicy HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/device_qcom_sepolicy -b $branch_kk && cd device_qcom_sepolicy
  git pull --rebase https://github.com/LineageOS/android_device_qcom_sepolicy -t $branch_los
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/device_qcom_sepolicy HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/device_qcom_sepolicy-legacy -b $branch_kk && cd device_qcom_sepolicy-legacy
  git pull --rebase https://github.com/LineageOS/android_device_qcom_sepolicy-legacy -t $branch_los
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/device_qcom_sepolicy-legacy HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

#  git clone ssh://git@github.com/mamutal91/kraken-sdk -b $branch_kk && cd kraken-sdk
#  git pull --rebase https://github.com/LineageOS/android_lineage-sdk -t $branch_los
#  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/kraken-sdk HEAD:refs/heads/$branch_kk && cd $tmp
#echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/packages_apps_Bluetooth -b $branch_kk && cd packages_apps_Bluetooth
  git pull --rebase https://github.com/LineageOS/android_packages_apps_Bluetooth -t $branch_los
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_Bluetooth HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/packages_apps_CustomParts -b $branch_kk && cd packages_apps_CustomParts
  git pull --rebase https://github.com/LineageOS/android_packages_apps_LineageParts -t $branch_los
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_CustomParts HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/packages_apps_DocumentsUI -b $branch_kk && cd packages_apps_DocumentsUI
  git pull --rebase https://github.com/LineageOS/android_packages_apps_DocumentsUI -t $branch_los
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_DocumentsUI HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/packages_apps_Launcher3 -b $branch_kk && cd packages_apps_Launcher3
  git pull --rebase https://github.com/LineageOS/android_packages_apps_Trebuchet -t $branch_los
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_Launcher3 HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/packages_apps_Settings -b $branch_kk && cd packages_apps_Settings
  git pull --rebase https://github.com/LineageOS/android_packages_apps_Settings -t $branch_los
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_Settings HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/packages_apps_Updater -b $branch_kk && cd packages_apps_Updater
  git pull --rebase https://github.com/LineageOS/android_packages_apps_Updater -t $branch_los
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_Updater HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/packages_overlays_Custom -b $branch_kk && cd packages_overlays_Custom
  git pull --rebase https://github.com/LineageOS/android_packages_overlays_Lineage -t $branch_los
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_overlays_Custom HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

#  git clone ssh://git@github.com/mamutal91/vendor_aosp -b $branch_kk && cd vendor_aosp
#  git pull --rebase https://github.com/LineageOS/android_vendor_lineage -t $branch_los
#  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/vendor_aosp HEAD:refs/heads/$branch_kk && cd $tmp
#echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/frameworks_base -b $branch_kk && cd frameworks_base
  git pull --rebase https://github.com/LineageOS/android_frameworks_base -t $branch_los
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/frameworks_base HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/prebuilts_clang_host_linux-x86 -b $branch_kk && cd prebuilts_clang_host_linux-x86
  git pull --rebase https://github.com/AOSiP/platform_prebuilts_clang_host_linux-x86 -t pie
  echo && git rebase && echo && git push ssh://git@github.com/mamutal91/prebuilts_clang_host_linux-x86 HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"
}

function tree() {
  for i in "${repostree[@]}"; do
    repo=${i}
    cd $tmp && rm -rf $repo
    git clone ssh://git@github.com/KrakenDevices/${i} -b $branch_kk && cd $repo
    git pull --rebase https://github.com/AOSiP-Devices/$repo -t pie
    echo && git rebase && git push ssh://git@github.com/KrakenDevices/$repo HEAD:refs/heads/$branch_kk --force
    echo -e "\n\e[33m------------------------------------------------------\e[m"
  done
}

function aosp() {
  echo -e "\n\e[31m\e[1m What is the name of the tag you want to merge? (Ex: android-10.0.0_r1)\e[m" ; read tag_aosp
  echo $tag_aosp
  cd $tmp

  git clone ssh://git@github.com/mamutal91/build -b $branch_kk
  cd build
  git pull https://android.googlesource.com/platform/build -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/build HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/build_soong -b $branch_kk
  cd build_soong
  git pull https://android.googlesource.com/platform/build/soong -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/build_soong HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/packages_apps_Bluetooth -b $branch_kk
  cd packages_apps_Bluetooth
  git pull https://android.googlesource.com/platform/packages/apps/Bluetooth -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/packages_apps_Bluetooth HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/packages_apps_DocumentsUI -b $branch_kk
  cd packages_apps_DocumentsUI
  git pull https://android.googlesource.com/platform/packages/apps/DocumentsUI -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/packages_apps_DocumentsUI HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/packages_apps_Launcher3 -b $branch_kk
  cd packages_apps_Launcher3
  git pull https://android.googlesource.com/platform/packages/apps/Launcher3 -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/packages_apps_Launcher3 HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/packages_apps_Settings -b $branch_kk
  cd packages_apps_Settings
  git pull https://android.googlesource.com/platform/packages/apps/Settings -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/packages_apps_Settings HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"

  git clone ssh://git@github.com/mamutal91/frameworks_base -b $branch_kk
  cd frameworks_base
  git pull https://android.googlesource.com/platform/frameworks/base -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/frameworks_base HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e "\n\e[33m------------------------------------------------------\e[m"
}

function create_backup() {
  echo -e "\n\e[31m\e[1m What is the name of the new backup branch?\e[m" ; read branch_backup
  for i in "${repos[@]}"; do
    repo=${i}
    cd $tmp && rm -rf $repo
    git clone ssh://git@github.com/mamutal91/${i} -b $branch_kk && cd $repo
    git checkout -b $branch_backup && git push origin $branch_backup
    echo -e "\n\e[33m------------------------------------------------------\e[m"
  done
}

function remove_backup(){
  echo -e "\n\e[31m\e[1m What is the name of the backup branch you want to remove?\e[m" ; read branch_backup
  for i in "${repos[@]}"; do
    repo=${i}
    cd $tmp && rm -rf $repo
    git clone ssh://git@github.com/mamutal91/${i} -b $branch_kk && cd $repo
    git push ssh://git@github.com/mamutal91/${i} --delete $branch_backup
    echo -e "\n\e[33m------------------------------------------------------\e[m"
  done
}

if [ -z $branch_kk ];then
  echo -e "\n\e[33m You need to specify a branch to work with!!!\e[m"
else
  echo -e "\n\n\e[33m Starting !!! \n\e[m"
  $action
fi

rm -rf $tmp
