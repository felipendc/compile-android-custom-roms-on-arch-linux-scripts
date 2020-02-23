#!/bin/bash
set -e

# This script was only possible thanks to "Erik Dubois"
# Website	:	https://www.erikdubois.be

git init
git config --global user.name "felipendc"
git config --global user.email "felipendc10@gmail.com"
sudo git config --system core.editor nano
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=25000'
git config --global push.default simple


echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
