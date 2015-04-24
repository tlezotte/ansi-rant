## ANSIbile - vagRANT
  
### How to run ansi-rant
> git clone https://github.com/tlezotte/ansi-rant ; ansi-rant/install.sh 
  
### What does the INSTALL.SH script do?
1. Installs [Homebrew](http://brew.sh/) and [Cask](http://caskroom.io/)
2. Homebrew and Cask will install __ansible__, __vagrant__ and __virtualbox__
3. Runs __vagrant up__ - This will run the Vagrantfile and run the Ansible playbook.yml
4. Runs __vagrant ssh__ - This will log you into your new Vagrant VM
  
### What does VAGRANT do?
1. Installs a command only VM box (http://bit.ly/rantboxes)
2. And it runs Ansible
  
### What does ANSIBLE do?
Ansible will setup your new VM the same every time. Ansi-rant installs and setup the following.  
  
1. Adds a default user
2. Installs and configures Apache
3. Installs PHP
4. Installs and configures Drupal
5. Installs and configures phpMyAdmin
6. Installs ElasticSearch
7. Installs Memcached
8. Installs Varnish
