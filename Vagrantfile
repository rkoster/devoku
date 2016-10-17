# -*- mode: ruby -*-
# vi: set ft=ruby :


$INIT = <<SCRIPT

sudo tee /etc/environment -a > /dev/null <<EOF
DEVOKU_SHARE_DIR=/vagrant
EOF
source /etc/environment

devoku env new
devoku pg createdb

SCRIPT


# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.box = "adaptivdesign/devoku"
  config.vm.box_url = "packer/images/ubuntu-16.04-virtualbox-0.1.0.box"
  config.vm.synced_folder '.', '/vagrant'
  config.vm.provision "shell", inline: $INIT, privileged: false

  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 4569, host: 4569
  config.vm.provider "virtualbox" do |provider|
     provider.memory = 2048
     provider.cpus = 2
  end

end
