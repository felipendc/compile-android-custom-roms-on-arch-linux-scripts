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
export CCACHE_DIR="${HOME}/.ccache"
export CCACHE_EXEC="$(which ccache)"
# ccache -M 100G

export KBUILD_BUILD_USER=mamutal91
export KBUILD_BUILD_HOST=MamutBox
export SELINUX_IGNORE_NEVERALLOWS=true
export CUSTOM_BUILD_TYPE=OFFICIAL

function site () {
  pwd=$(pwd)
  cd /var/www/krakenproject.club
  sudo rm -rf css js favicon.ico index.html
  git clone https://github.com/andersonmendess/kraken -b prod
  cd kraken
  mv * .. && cd ..
  rm -rf kraken
  cd $pwd
}

function tree () {
  pwd=$(pwd)
  cd /home/mamutal91/aosp
  rm -rf device/xiaomi
  git clone ssh://git@github.com/mamutal91/device_xiaomi_beryllium -b ten device/xiaomi/beryllium
  git clone ssh://git@github.com/mamutal91/device_xiaomi_sdm845-common -b ten device/xiaomi/sdm845-common
  cd $pwd
}

function up () {
  cp -rf ${1} /var/www/krakenproject.club/building
}

function upload () {
  scp /home/mamutal91/kk/out/target/product/beryllium/${1} mamutal91@frs.sourceforge.net:/home/frs/project/krakenproject/beryllium
}

function fetch () {
  echo "lineage-${2}.1"
  git fetch https://github.com/LineageOS/android_${1} lineage-${2}.1
}

function push () {
  git push ssh://git@github.com/mamutal91/${1} HEAD:refs/heads/ten --force && cd .. && rm -rf ${1}
#  git push ssh://git@github.com/aosp-forking/${1} HEAD:refs/heads/${1} --force
}

function p () {
  git cherry-pick ${1}
}

function c () {
  git clone https://github.com/LineageOS/android_${1} -b lineage-17.1 ${1} && cd ${1}
}

function scripts () {
  scripts=$(pwd)
  rm -rf $HOME/.tmp
  rm -rf $HOME/.zshrc
  rm -rf $HOME/.apt.sh
  rm -rf $HOME/kk/merging.sh
  rm -rf $HOME/kk/mka.sh
  rm -rf $HOME/kk/hal.sh
  rm -rf $HOME/kk/gapps.sh
  cd $HOME && wget https://raw.githubusercontent.com/mamutal91/scripts/master/.zshrc
  cd $HOME && rm -rf .apt.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/.apt.sh && chmod +x .apt.sh
  cd $HOME/kk && rm -rf merging.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/merging.sh && chmod +x merging.sh
  cd $HOME/kk && rm -rf mka.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/mka.sh && chmod +x mka.sh
  cd $HOME/kk && rm -rf hal.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/hal.sh && chmod +x hal.sh
  cd $HOME/kk && rm -rf gapps.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/gapps.sh && chmod +x gapps.sh
  cd $scripts
  source $HOME/.zshrc
  clear
}
