#!/bin/bash


defaultbox="iamseth/rhel-7.3"
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
    brew cask install virtualbox vagrant-manager
fi

brew cleanup

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