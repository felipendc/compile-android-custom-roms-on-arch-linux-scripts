#!/bin/bash
# github.com/mamutal91

ROM=$(pwd)
aosp=.repo/manifests/default.xml
kraken=.repo/manifests/snippets/kraken.xml
caf=.repo/manifests/snippets/caf.xml

DATE=${1}

rm -rf $ROM/changelog_tmp.txt
rm -rf $ROM/changelog.txt
echo > $ROM/changelog_tmp.txt
echo $DATE >> $ROM/changelog.txt

function changelog(){
    git log --since="$DATE" --pretty=format:"* %s (%aN)" > $ROM/changelog_tmp.txt
    cat $ROM/changelog_tmp.txt >> $ROM/changelog.txt
}

name_aosp=($(awk -F '"' '/project path/{print $4}' $aosp))
path_aosp=($(awk -F '"' '/project path/{print $2}' $aosp))
blacklist_aosp=()

function changelog_aosp(){
	for (( i = j = 0; i < ${#path_aosp[@]}, j < ${#name_aosp[@]}; i++, j++ )); do
		if ! printf '%s\n' "${blacklist_aosp[@]}" | grep -Eqw "${name_aosp[j]}"
		then
			echo ">> Directory = ${path_aosp[i]}"
			cd $ROM/${path_aosp[i]}
      changelog
			cd $ROM
		fi
	done
}

name_kraken=($(awk -F '"' '/project path/{print $4}' $kraken))
path_kraken=($(awk -F '"' '/project path/{print $2}' $kraken))
blacklist_kraken=()

function changelog_kraken(){
	for (( i = j = 0; i < ${#path_kraken[@]}, j < ${#name_kraken[@]}; i++, j++ )); do
		if ! printf '%s\n' "${blacklist_kraken[@]}" | grep -Eqw "${name_kraken[j]}"
		then
			echo ">> Directory = ${path_kraken[i]}"
			cd $ROM/${path_kraken[i]}
      changelog
			cd $ROM
		fi
	done
}

name_caf=($(awk -F '"' '/project path/{print $4}' $caf))
path_caf=($(awk -F '"' '/project path/{print $2}' $caf))
blacklist_caf=()

function changelog_caf(){
	for (( i = j = 0; i < ${#path_caf[@]}, j < ${#name_caf[@]}; i++, j++ )); do
		if ! printf '%s\n' "${blacklist_caf[@]}" | grep -Eqw "${name_caf[j]}"
		then
			echo ">> Directory = ${path_caf[i]}"
			cd $ROM/${path_caf[i]}
      changelog
			cd $ROM
		fi
	done
}

changelog_aosp
changelog_kraken
changelog_caf

echo "**************************************"
echo ""
echo ""
cat $ROM/changelog.txt
echo ""
echo ""
echo ""
rm -rf $ROM/changelog_tmp.txt
