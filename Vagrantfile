# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

#Vagrant.require_version ">= 1.4.0"
if `vagrant --version` < 'Vagrant 1.4.0'
    abort('Your Vagrant is too old. Please install at least 1.4.0')
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.hostname = ENV['QUICKSTART_DOMAIN']
  config.vm.network :private_network, ip: "10.86.73.82"
  config.vm.network :forwarded_port, guest: 9200, host: 9200
  config.vm.network :forwarded_port, guest: 9300, host: 9300
  config.vm.network :forwarded_port, guest: 5601, host: 5601
  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.synced_folder ".", "/srv"

  # Sync materials
  config.vm.synced_folder "www", "/home/vagrant/www"
  config.vm.synced_folder "talks", "/home/vagrant/.talks"

  # Address a bug in an older version of Puppet
  # See http://stackoverflow.com/questions/10894661/augeas-support-on-my-vagrant-machine
  config.vm.provision :shell, :inline => "if ! dpkg -s puppet > /dev/null; then sudo apt-get update --quiet --yes && sudo apt-get install puppet --quiet --yes; fi"

  # Provision everything we need with Puppet
  config.vm.provision :puppet do |puppet|
    puppet.module_path = "puppet/modules"
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "init.pp"
    puppet.options = ['--templatedir', '/srv/puppet/files']
    puppet.facter = {
      "quickstart_domain" => 'vip-training-days.dev',
    }
  end

end
