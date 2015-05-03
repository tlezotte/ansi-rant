#!/bin/bash


defaultbox="chef/centos-6.6"

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

# check to see if directory exists
if [ -d "$OS" ];
then
    printf "\n** The directory $OS already exists **\n"
    exit
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

# Start installing
vagrant up

# Open default website
open http://localhost:8080

# Login to VM
vagrant ssh
