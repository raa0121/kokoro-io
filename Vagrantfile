# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define 'kokoro' do |c|
    c.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
    c.vm.box = "ubuntu_1404_amd64"
    c.vm.box_check_update = true
    c.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    c.vm.network "private_network", ip: "192.168.33.10"
    c.vm.network "forwarded_port", guest: 80, host: 8080
    c.vm.provision :shell, inline: <<-EOC
cat /etc/apt/sources.list | sed -e 's|http://[^ ]*|mirror://mirrors.ubuntu.com/mirrors.txt|g' > /tmp/sources.list
if !(diff -q /etc/apt/sources.list /tmp/sources.list); then
  mv /tmp/sources.list /etc/apt/sources.list
  apt-get update
fi
    EOC
  end

end
