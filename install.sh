#!/bin/bash


defaultbox="chef/centos-6.6"
defaultuser="vagrant"
defaultroot="/home/vagrant"


clear

echo -n "Enter a Vagrant Box (http://bit.ly/rantboxes) [$defaultbox]: "
read box

echo -n "Create a users [$defaultuser]: "
read user

echo -n "Enter users home directory [$defaultroot]: "
read root


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

#
# -- user section --
#
# set default is enter is pressed
if [ -z "$user" ];
then
    box=$defaultuser
fi
#Switch user
sed -i "" "s|default_user: vagrant|default_user: $user|" ansi-rant/playbook.yml
sed -i "" "s|default_group: vagrant|default_group: $user|" ansi-rant/playbook.yml

#
# -- root section --
#
# set default is enter is pressed
if [ -z "$root" ];
then
    root=$defaultroot
fi
#Switch software root
sed -i "" "s|default_home: /home/vagrant|default_home: $root|" ansi-rant/playbook.yml


# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Installing brew software
brew_check="brew info brew-cask | grep Error"
if [ ${#brew_check} -ne 0 ];
then
    brew install brew-cask
fi
ansible_check="brew info ansible | grep Error"
if [ ${#ansible_check} -ne 0 ];
then
    brew install ansible
fi

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
#mv ansi-rant $OS
cd $OS

# Start installing
vagrant up

# Open default website
open http://localhost:8080

# Login to VM
vagrant ssh
