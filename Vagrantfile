# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "private_network", ip: "10.2.2.2"
  config.vm.hostname = "vmnodejs"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "2"
    vb.memory = "2048"
  end

  config.vm.provision :shell, path: "bootstrap.sh", privileged: false

  config.vm.synced_folder ".", "/vagrant", type: "nfs"
end
