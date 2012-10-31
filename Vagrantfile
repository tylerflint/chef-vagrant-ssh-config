#!/usr/bin/env ruby

require 'berkshelf/vagrant'
require 'vagrant-vbguest' unless defined? VagrantVbguest::Config

Vagrant::Config.run do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.berkshelf.config_path = './knife.rb'

  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
      "recipe[vagrant-ssh-config::default]"
    ]
  end

end
