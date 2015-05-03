#!/bin/bash

# TODO: have this script update Vagrantfile with variables

defaultbox="chef/centos-6.6"
defaultboxip="192.168.10.10"
defaultdomain="vagrant.com"

clear

echo -n "Enter a Vagrant Box (http://bit.ly/rantboxes) [$defaultbox]: "
read box


#
# -- box section --
#
# set default is enter is pressed
if [ -z "$box" ];
then
    box=$defaultbox
fi

# split vagrant box string
PROV=${box%/*}
OS=${box##*/}
boxhostname=${OS//[^[:alnum:]]/}.$defaultdomain

# check to see if directory exists
if [ -d "$OS" ];
then
    printf "\n** The directory $OS already exists **\n"
    exit
fi

#
# -- ip address section --
#
echo -n "Enter an IP address for $boxhostname [$defaultboxip]: "
read boxip

# set default if enter is pressed
if [ -z "$boxip" ];
then
    boxip=$defaultboxip
fi

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Installing brew software
brew install brew-cask
brew install ansible

# Install cask software
if [ ! -d "/opt/homebrew-cask/Caskroom/vagrant" ];
then
    brew cask install vagrant
fi

if [ ! -d "/Applications/VirtualBox.app" ];
then
    brew cask install virtualbox
fi

brew cleanup

# Rename git directory to centos6
mv ansi-rant $OS
cd $OS

# Update Vagrantfile
sed -i "" "s/192.168.10.10/$boxip/" playbook.yml

# Start installing
vagrant up

# Open default website
open http://$boxip:8080

# change user directory to be open (temp)
#chmod -R 755 somapp

# Login to VM
vagrant ssh
