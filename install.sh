#!/bin/bash


defaultbox="geerlingguy/centos7"
defaultuser="vagrant"
defaultroot="/home/vagrant"


clear

# process arguments
while getopts d option
do
 case "${option}"
 in
    d) DEFAULT=true;;
 esac
done


# set application variables
if [ $DEFAULT ]; then
    # settings from uesr prompts
    box=$defaultbox
    user=$defaultuser
    root=$defaultroot
elif [ "$#" -eq 3 ]; then
    # settings from command line
    box=$1
    user=$2
    root=$3    
elif [ "$#" -ne 3 ]; then
    echo -n "Enter a Vagrant Box (http://bit.ly/rantboxes) [$defaultbox]: "
    read box

    echo -n "Create a users [$defaultuser]: "
    read user

    echo -n "Enter users home directory [$defaultroot]: "
    read root

    # settings from uesr selecting defaults
    [ -z "$box" ] && box=$defaultbox
    [ -z "$user" ] && user=$defaultuser
    [ -z "$root" ] && root=$defaultroot
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
#Switch user
sed -i "" "s|default_user: vagrant|default_user: $user|" ansi-rant/playbook.yml
sed -i "" "s|default_group: vagrant|default_group: $user|" ansi-rant/playbook.yml

#
# -- root section --
#
#Switch software root
sed -i "" "s|default_home: /home/vagrant|default_home: $root|" ansi-rant/playbook.yml


# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /dev/null 2>&1
fi

# Installing brew software
ansible_check="brew info ansible | grep Error"
if [ ! -d "/usr/local/Cellar/ansible" ];
then
    brew install ansible > /dev/null 2>&1
fi

# Install cask software
if [ ! -d "/usr/local/Caskroom/vagrant" ];
then
    brew cask install vagrant vagrant-manager > /dev/null 2>&1
fi

if [ ! -d "/usr/local/Caskroom/virtualbox" ];
then
    brew cask install virtualbox > /dev/null 2>&1
fi

brew cleanup > /dev/null 2>&1

# Rename git directory to box name
mv ansi-rant $OS
cd $OS

# Update Vagrantfile
sed -i "" "s|BOXNAME|$box|" Vagrantfile

# Start installing
vagrant up

# Open default website
open http://localhost:8080

# Login to VM
vagrant ssh
