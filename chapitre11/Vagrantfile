# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
        config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"], type: "virtualbox"
    else
        config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    end

config.vm.define "swarm-master" do |d|
    d.vm.box = "dunod-docker/centos7"
    d.vm.hostname = "swarm-master"
    d.vm.network "private_network", ip: "10.100.192.200"
    d.vm.provision :shell, path: "scripts/docker_installation.sh"
    d.vm.provider "virtualbox" do |v|
    v.name = "swarm-master"
    v.memory = 1024
    end
end

(1..2).each do |i|
    config.vm.define "swarm-slave-0#{i}" do |d|
        d.vm.box = "dunod-docker/centos7"
        d.vm.hostname = "swarm-slave-0#{i}"
        d.vm.network "private_network", ip: "10.100.192.20#{i}"
        d.vm.provision :shell, path: "scripts/docker_installation.sh"
        d.vm.provider "virtualbox" do |v|
        v.name = "swarm-slave-0#{i}"
        v.memory = 1024
        end
    end
end

if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
end

end
