# ANSIbile - vagRANT

## How to run ansi-rant

### Prompt user about Vagrant Box

```sh
cd <project directory>  
git clone https://github.com/tlezotte/ansi-rant ; ansi-rant/install.sh
```

#### Use default Vagrant Box settings

```sh
git clone https://github.com/tlezotte/ansi-rant ; ansi-rant/install.sh -d
```

#### Provide Vagrant Box settings

```sh
git clone https://github.com/tlezotte/ansi-rant ; ansi-rant/install.sh [box] [user] [home dir]
```

## What does the INSTALL.SH script do?

1. Installs [Homebrew](http://brew.sh/) and [Cask](http://caskroom.io/)
2. Homebrew and Cask will install **ansible**, **vagrant** and **virtualbox**
3. Runs **vagrant up** - This will run the Vagrantfile and run the Ansible playbook.yml
4. Runs **vagrant ssh** - This will log you into your new Vagrant VM

## What does VAGRANT do?

1. Installs a cli only VM box (http://bit.ly/rantboxes)
2. And it runs Ansible

## What does ANSIBLE do?

Ansible will setup your new VM the same every time. Ansi-rant installs and setup the following.

1. Adds a default user
2. Installs and configures [Apache HTTPD](http://httpd.apache.org)
3. Installs [PHP](http://php.net)
4. Installs and configures [Drupal](https://www.drupal.org)
5. Installs and configures [phpMyAdmin](https://www.phpmyadmin.net)
6. Installs [MySQL](http://www.mysql.com)
7. Installs [Composer](https://getcomposer.org)
8. Installs [Drush](http://www.drush.org)
9. Installs [NodeJS](https://nodejs.org)
