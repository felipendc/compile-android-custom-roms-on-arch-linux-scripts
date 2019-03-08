export ZSH="/home/mamutal91/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git archlinux extract web-search)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

function upload () {
  scp /home/mamutal91/kk/out/target/product/beryllium/${1} mamutal91@frs.sourceforge.net:/home/frs/project/krakenproject/beryllium
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
  rm -rf $HOME/viper/merging.sh
  rm -rf $HOME/viper/mka.sh
  rm -rf $HOME/kk/merging.sh
  rm -rf $HOME/kk/mka.sh
  rm -rf $HOME/kk_pie/merging.sh
  rm -rf $HOME/kk_pie/mka.sh
  cd $HOME/viper && rm -rf merging.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/merging.sh && chmod +x merging.sh
  cd $HOME/viper && rm -rf mka.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/mka.sh && chmod +x mka.sh
  cd $HOME/kk && rm -rf merging.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/merging.sh && chmod +x merging.sh
  cd $HOME/kk && rm -rf mka.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/mka.sh && chmod +x mka.sh
  cd $HOME/kk_pie && rm -rf merging.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/merging.sh && chmod +x merging.sh
  cd $HOME/kk_pie && rm -rf mka.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/mka.sh && chmod +x mka.sh
  cd $scripts
  clear
}
