

meu_branch=ten
lineage=lineage-17.0
end=***********************************

mkdir tmp && cd tmp

git clone ssh://git@github.com/mamutal91/build -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_build -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/build HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

git clone ssh://git@github.com/mamutal91/build_soong -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_build_soong -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/build_soong HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

git clone ssh://git@github.com/mamutal91/custom-sdk -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_lineage-sdk -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/custom-sdk HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

git clone ssh://git@github.com/mamutal91/device_custom_sepolicy -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_device_lineage_sepolicy -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/device_custom_sepolicy HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

#device_qcom_sepolicy-legacy

#manifest

git clone ssh://git@github.com/mamutal91/packages_apps_Bluetooth -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_packages_apps_Bluetooth -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_Bluetooth HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

git clone ssh://git@github.com/mamutal91/packages_apps_CustomParts -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_packages_apps_LineageParts -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_CustomParts HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

git clone ssh://git@github.com/mamutal91/packages_apps_DocumentsUI -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_packages_apps_DocumentsUI -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_DocumentsUI HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

git clone ssh://git@github.com/mamutal91/packages_apps_Launcher3 -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_packages_apps_Trebuchet -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_Launcher3 HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

git clone ssh://git@github.com/mamutal91/packages_apps_Settings -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_packages_apps_Settings -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_Settings HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

git clone ssh://git@github.com/mamutal91/packages_apps_ThemePicker -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_packages_apps_ThemePicker -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_ThemePicker HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

git clone ssh://git@github.com/mamutal91/packages_apps_Updater -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_packages_apps_Updater -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_Updater HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

git clone ssh://git@github.com/mamutal91/packages_apps_Updater -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_packages_apps_Updater -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_apps_Updater HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

git clone ssh://git@github.com/mamutal91/packages_overlays_Custom -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_packages_overlays_Lineage -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/packages_overlays_Custom HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

git clone ssh://git@github.com/mamutal91/vendor_aosp -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_vendor_lineage -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/vendor_aosp HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

# FRAMEWORKS_BASE

git clone ssh://git@github.com/mamutal91/frameworks_base -b $meu_branch && cd build
git pull --rebase https://github.com/LineageOS/android_frameworks_base -t $lineage
echo && git rebase && echo && git push ssh://git@github.com/mamutal91/frameworks_base HEAD:refs/heads/$meu_branch --force && cd ..
echo -e $end

cd .. && rm -rf tmp
