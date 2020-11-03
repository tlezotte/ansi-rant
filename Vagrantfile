# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "BOXNAME"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 443, host: 8443, host_ip: "127.0.0.1"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with ansible.
  config.vm.provision :ansible do |ansible|
    ansible.playbook = "playbook.yml"
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
#    yum-config-manager --enable centos-sclo-rh-testing
    yum -y update
#    yum -y install centos-release-scl epel-release gcc libaio-devel wget unzip tar xz git mail telnet
#    yum -y install httpd24 httpd24-apr httpd24-apr-util httpd24-httpd httpd24-httpd-tools \
#                   httpd24-libnghttp2 httpd24-mod_ssl httpd24-runtime
#    yum -y install rh-php73 rh-php73-php-cli rh-php73-php-common rh-php73-php-devel \
#                   rh-php73-php-gd rh-php73-php-gmp rh-php73-php-imap rh-php73-php-ldap rh-php73-php-mbstring \
#                   rh-php73-php-mysqlnd rh-php73-php-odbc rh-php73-php-opcache rh-php73-php-pdo \
#                   rh-php73-php-pear rh-php73-php-pecl-jsonc rh-php73-php-pecl-jsonc-devel \
#                   rh-php73-php-pecl-memcache rh-php73-php-process rh-php73-php-soap rh-php73-php-tidy \
#                   rh-php73-php-xml rh-php73-runtime sclo-php73-php-mcrypt libmcrypt ssmtp rh-php73-php-fpm
    yum -y install ansible ansible-lint python3
#    pip3 install molecule docker testinfra yamllint flake8
  SHELL
end
