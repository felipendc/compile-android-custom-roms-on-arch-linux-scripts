export ZSH="/home/mamutal91/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git archlinux extract web-search)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export TERM="xterm-256color"
export EDITOR="nano"
export LANG="pt_BR.UTF-8"
export LC_ALL="pt_BR.UTF-8"
export LANGUAGE="pt_BR.UTF-8"
export LC_CTYPE="pt_BR.UTF-8"

export PATH=~/.bin:$PATH
export PATH=$PATH:~/.android-sdk/tools/
export PATH=$PATH:~/.android-sdk/platform-tools/
export JAVA_HOME=/usr/lib/jvm/java

export USE_CCACHE=1
export KBUILD_BUILD_USER=mamutal91
export KBUILD_BUILD_HOST=MamutBox
export SELINUX_IGNORE_NEVERALLOWS=true
export CUSTOM_BUILD_TYPE=OFFICIAL
export VIPER_BUILD_TYPE=OFFICIAL

function site () {
  pwd=$(pwd)
  cd /var/www/krakenproject.club
  sudo rm -rf *
  git clone https://github.com/andersonmendess/kraken -b prod
  cd kraken
  mv * .. && cd ..
  rm -rf kraken
  cd $pwd
}

function m () {
. build/envsetup.sh && lunch aosp_beryllium-userdebug && make -j$(nproc --all) bacon 2>&1 | tee log.txt
}

function sync () {
  repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags --force-sync
}

function clean () {
  make clobber && make clean
}

function upload () {
  scp /home/mamutal91/kk/out/target/product/beryllium/${1} mamutal91@frs.sourceforge.net:/home/frs/project/krakenproject/beryllium
}

function upload_viper () {
  scp /home/mamutal91/viper/out/target/product/beryllium/${1} mamutal91@frs.sourceforge.net:/home/frs/project/viper-project/beryllium
}

function fetch () {
  echo "lineage-${2}.0"
  git fetch https://github.com/LineageOS/android_${1} lineage-${2}.0
}

function push () {
  git push ssh://git@github.com/mamutal91/${1} HEAD:refs/heads/${2} --force
  git push ssh://git@github.com/KrakenProject/${1} HEAD:refs/heads/${2} --force
}

function p () {
 git cherry-pick ${1}
}

function scripts () {
  scripts=$(pwd)
  rm -rf $HOME/.tmp
  rm -rf $HOME/.zshrc
  rm -rf $HOME/.pacman.sh
  rm -rf $HOME/viper/merging.sh
  rm -rf $HOME/viper/mka.sh
  rm -rf $HOME/kk/merging.sh
  rm -rf $HOME/kk/mka.sh
  cd $HOME && wget https://raw.githubusercontent.com/mamutal91/scripts/master/.zshrc
  cd $HOME && rm -rf .pacman.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/.pacman.sh && chmod +x .pacman.sh
  cd $HOME/viper && rm -rf merging.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/merging.sh && chmod +x merging.sh
  cd $HOME/viper && rm -rf mka.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/mka.sh && chmod +x mka.sh
  cd $HOME/kk && rm -rf merging.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/merging.sh && chmod +x merging.sh
  cd $HOME/kk && rm -rf mka.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/mka.sh && chmod +x mka.sh
  cd $scripts
  clear
}
