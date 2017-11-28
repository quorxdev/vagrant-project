# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "debian/jessie64"
  config.vm.box_check_update = false
  
  # synced folders
  #config.vm.synced_folder ".", "/vagrant", disabled: true
  #config.vm.synced_folder ".", "/var/www"
  
  config.vm.synced_folder ".", "/vagrant"

  # network
  config.vm.network "private_network", type: "dhcp"

  # provider
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 2
    vb.memory = "1024"
  end

  # provision
  config.vm.provision :shell, :path => "provision/bootstrap.sh"
end