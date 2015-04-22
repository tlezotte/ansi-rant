## ANSIbile - vagRANT
  
### How to run ansi-rant
> cd ~/Vagrant _this is just an example_  
> git clone https://github.com/tlezotte/ansi-rant  
> mv ansi-rant centos6  
> cd centos6  
> chmod +x install.sh  
> .\install.sh  
  
### What does the __install.sh__ script do?
1. Installs [Homebrew](http://brew.sh/) and [Cask](http://caskroom.io/)
2. Homebrew and Cask will install __ansible__, __vagrant__ and __virtualbox__
3. Runs __vagrant up__ - This will run the Vagrantfile and run the Ansible playbook.yml
4. Runs __vagrant ssh__ - This will log you into your new Vagrant VM
