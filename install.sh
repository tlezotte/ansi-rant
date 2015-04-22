#!/bin/bash

echo -n "Enter a Vagrant Box (http://bit.ly/rantboxes) [chef/centos-6.6]: "
read box

# set default is enter is pressed
if [ -z "$box" ];
then
    box="chef/centos-6.6"
fi

# split vagrant box string
PROV=${box%/*}
OS=${box##*/}


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
brew cask install vagrant
brew cask install virtualbox

brew cleanup

# Rename git directory to centos6
mv ansi-rant $OS
cd $OS

# Start installing
vagrant up

# Login to VM
vagrant ssh

