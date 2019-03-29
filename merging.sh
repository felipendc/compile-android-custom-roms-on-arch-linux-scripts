#!/bin/bash
# github.com/mamutal91

# rm -rf merging.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/merging.sh && chmod +x merging.sh && ./merging.sh

clear

function push () {
  git push ssh://git@github.com/mamutal91/${1} HEAD:refs/heads/${2} --force
  git push ssh://git@github.com/KrakenProject/${1} HEAD:refs/heads/${2} --force
}

branch_kk=ten
branch_los=lineage-17.0
date=$(date +"%Y%m%d-%H%M")
tmp=/home/mamutal91/.tmp/merging_$date/
mkdir -p $tmp
end="\n\e[33m------------------------------------------------------\e[m"

echo -e "\n\e[31m\e[1m ## What do you want to do\e[m"
echo -e "\n\e[33m 1. Sync repositories \e[4m@KrakenProject\e[m\e[33m with \e[4m@mamutal91\e[m \e[33m[enter]\e[m"
echo -e "\e[36m 2. Pull rebase Lineage\e[m"
echo -e "\e[32m 3. Update tree (beryllium/whyred)\e[m"
echo -e "\e[34m 4. Merge tag AOSP\e[m"
echo -e "\e[34m 5. Create BACKUP branch\e[m"
echo -e "\e[36m 6. Remove BACKUP branch\e[m"
echo -e "\n\e[36m X. Nothing\e[m"

read action
  case "$action" in
    1|"")  action="mamutal91" ;;
    2)  action="lineage" ;;
    3)  action="tree" ;;
    4)  action="aosp" ;;
    5)  action="create_backup" ;;
    6)  action="remove_backup" ;;
    x|n|a) ;;
  esac

readonly repos=(
  build
  build_soong
  device_custom_sepolicy
  device_qcom_sepolicy
  device_qcom_sepolicy-legacy
  custom-sdk
  packages_apps_Bluetooth
  packages_apps_CustomParts
  packages_apps_DocumentsUI
  packages_apps_Launcher3
  packages_apps_Settings
  packages_apps_Updater
  packages_overlays_Custom
  vendor_aosp
  frameworks_base
#  prebuilts_clang_host_linux-x86
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
    echo -e $end
  done
}

function lineage() {
  cd $tmp

  echo -e "\n\e[33m Attention! The following repositories are disabled, and must be updated manually:\e[m"
  echo -e "\n\e[33m manifest\e[m"
  echo -e "\e[33m vendor_aosp\e[m"
  echo -e "\e[33m prebuilts_clang_host_linux-x86\e[m\n"

  git clone ssh://git@github.com/mamutal91/build -b $branch_kk && cd build
  git pull --rebase https://github.com/LineageOS/android_build -t $branch_los
  echo && git rebase && echo && push build $branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/build_soong -b $branch_kk && cd build_soong
  git pull --rebase https://github.com/LineageOS/android_build_soong -t $branch_los
  echo && git rebase && echo && push build_soong $branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/device_custom_sepolicy -b $branch_kk && cd device_custom_sepolicy
  git pull --rebase https://github.com/LineageOS/android_device_lineage_sepolicy -t $branch_los
  echo && git rebase && echo && push device_custom_sepolicy $branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/device_qcom_sepolicy -b $branch_kk && cd device_qcom_sepolicy
  git pull --rebase https://github.com/LineageOS/android_device_qcom_sepolicy -t $branch_los
  echo && git rebase && echo && push device_qcom_sepolicy $branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/device_qcom_sepolicy -b ten-legacy-um device_qcom_sepolicy_legacy-um && cd device_qcom_sepolicy_legacy-um
  git pull --rebase https://github.com/LineageOS/android_device_qcom_sepolicy -t lineage-17.0-legacy-um
  echo && git rebase && echo && push device_qcom_sepolicy ten-legacy-um && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/device_qcom_sepolicy-legacy -b $branch_kk && cd device_qcom_sepolicy-legacy
  git pull --rebase https://github.com/LineageOS/android_device_qcom_sepolicy-legacy -t $branch_los
  echo && git rebase && echo && push device_qcom_sepolicy-legacy $branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/custom-sdk -b $branch_kk && cd custom-sdk
  git pull --rebase https://github.com/LineageOS/android_lineage-sdk -t $branch_los
  echo && git rebase && echo && push custom-sdk $branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/packages_apps_Bluetooth -b $branch_kk && cd packages_apps_Bluetooth
  git pull --rebase https://github.com/LineageOS/android_packages_apps_Bluetooth -t $branch_los
  echo && git rebase && echo && push packages_apps_Bluetooth $branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/packages_apps_CustomParts -b $branch_kk && cd packages_apps_CustomParts
  git pull --rebase https://github.com/LineageOS/android_packages_apps_LineageParts -t $branch_los
  echo && git rebase && echo && push packages_apps_CustomParts $branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/packages_apps_DocumentsUI -b $branch_kk && cd packages_apps_DocumentsUI
  git pull --rebase https://github.com/LineageOS/android_packages_apps_DocumentsUI -t $branch_los
  echo && git rebase && echo && push packages_apps_DocumentsUI $branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/packages_apps_Launcher3 -b $branch_kk && cd packages_apps_Launcher3
  git pull --rebase https://github.com/LineageOS/android_packages_apps_Trebuchet -t $branch_los
  echo && git rebase && echo && push packages_apps_Launcher3 $branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/packages_apps_Settings -b $branch_kk && cd packages_apps_Settings
  git pull --rebase https://github.com/LineageOS/android_packages_apps_Settings -t $branch_los
  echo && git rebase && echo && push packages_apps_Settings $branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/packages_apps_Updater -b $branch_kk && cd packages_apps_Updater
  git pull --rebase https://github.com/LineageOS/android_packages_apps_Updater -t $branch_los
  echo && git rebase && echo && push packages_apps_Updater $branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/packages_overlays_Custom -b $branch_kk && cd packages_overlays_Custom
  git pull --rebase https://github.com/LineageOS/android_packages_overlays_Lineage -t $branch_los
  echo && git rebase && echo && push packages_overlays_Custom $branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/frameworks_base -b $branch_kk && cd frameworks_base
  git pull --rebase https://github.com/LineageOS/android_frameworks_base -t $branch_los
  echo && git rebase && echo && push frameworks_base $branch_kk && cd $tmp
  echo -e $end
}

function tree() {
  for i in "${repostree[@]}"; do
    repo=${i}
    cd $tmp && rm -rf $repo
    git clone ssh://git@github.com/KrakenDevices/${i} -b $branch_kk && cd $repo
    git pull --rebase https://github.com/AOSiP-Devices/$repo -t pie
    echo && git rebase && git push ssh://git@github.com/KrakenDevices/$repo HEAD:refs/heads/$branch_kk --force
    echo -e $end
  done
}

function aosp() {
  echo -e "\n\e[31m\e[1m ## What is the name of the tag you want to merge? (Ex: android-10.0.0_r1)\e[m" ; read tag_aosp
  echo $tag_aosp
  cd $tmp

  git clone ssh://git@github.com/mamutal91/build -b $branch_kk
  cd build
  git pull https://android.googlesource.com/platform/build -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/build HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/build_soong -b $branch_kk
  cd build_soong
  git pull https://android.googlesource.com/platform/build/soong -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/build_soong HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/packages_apps_Bluetooth -b $branch_kk
  cd packages_apps_Bluetooth
  git pull https://android.googlesource.com/platform/packages/apps/Bluetooth -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/packages_apps_Bluetooth HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/packages_apps_DocumentsUI -b $branch_kk
  cd packages_apps_DocumentsUI
  git pull https://android.googlesource.com/platform/packages/apps/DocumentsUI -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/packages_apps_DocumentsUI HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/packages_apps_Launcher3 -b $branch_kk
  cd packages_apps_Launcher3
  git pull https://android.googlesource.com/platform/packages/apps/Launcher3 -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/packages_apps_Launcher3 HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/packages_apps_Settings -b $branch_kk
  cd packages_apps_Settings
  git pull https://android.googlesource.com/platform/packages/apps/Settings -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/packages_apps_Settings HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e $end

  git clone ssh://git@github.com/mamutal91/frameworks_base -b $branch_kk
  cd frameworks_base
  git pull https://android.googlesource.com/platform/frameworks/base -t $tag_aosp
  echo && git push ssh://git@github.com/mamutal91/frameworks_base HEAD:refs/heads/$branch_kk && cd $tmp
  echo -e $end
}

function create_backup() {
  echo -e "\n\e[31m\e[1m ## What is the name of the new backup branch?\e[m" ; read branch_backup
  for i in "${repos[@]}"; do
    repo=${i}
    cd $tmp && rm -rf $repo
    git clone ssh://git@github.com/mamutal91/${i} -b $branch_kk && cd $repo
    git checkout -b $branch_backup && git push origin $branch_backup
    echo -e $end
  done
}

function remove_backup(){
  echo -e "\n\e[31m\e[1m ## What is the name of the backup branch you want to remove?\e[m" ; read branch_backup
  for i in "${repos[@]}"; do
    repo=${i}
    cd $tmp && rm -rf $repo
    git clone ssh://git@github.com/mamutal91/${i} -b $branch_kk && cd $repo
    git push ssh://git@github.com/mamutal91/${i} --delete $branch_backup
    echo -e $end
  done
}

if [ -z $branch_kk ];then
  echo -e "\n\e[33m You need to specify a branch to work with!!!\e[m"
else
  echo -e "\n\n\e[33m Starting !!! \n\e[m"
  $action
fi

rm -rf $tmp
