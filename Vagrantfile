# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
# region multi-machine-setup
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
# region provisioning-zenoss
  config.vm.define "zenoss" do |zenoss_server|
# endregion provisioning-zenoss    # ...
# endregion multi-machine-setup
    # All Vagrant configuration is done here. The most common configuration
    # options are documented and commented below. For a complete reference,
    # please see the online documentation at vagrantup.com.

    # Every Vagrant virtual environment requires a box to build off of.
# region multi-machine-setup
    zenoss_server.vm.box = "CentOS-6.2-x86_64"
# endregion multi-machine-setup

    # The url from where the 'zenoss_server.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
# region multi-machine-setup
    zenoss_server.vm.box_url = "https://dl.dropboxusercontent.com/u/17905319/vagrant-boxes/CentOS-6.2-x86_64.box"

# endregion multi-machine-setup
    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # zenoss_server.vm.network :forwarded_port, guest: 8080, host: 8080

    # Connect to the Zenoss server via localhost:8080
    # ssh -p 2222 -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -N -L 8080:127.0.0.1:8080 root@localhost

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
# region multi-machine-setup
    zenoss_server.vm.network :private_network, ip: "10.0.0.2"
# endregion multi-machine-setup    # ...

    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    # zenoss_server.vm.network :public_network

    # If true, then any SSH connections made will enable agent forwarding.
    # Default value: false
    # zenoss_server.ssh.forward_agent = true

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # zenoss_server.vm.synced_folder "/host/folder", "/guest/path"

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.

    zenoss_server.vm.provider :virtualbox do |vb|
      vb.memory = 3000

      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    # View the documentation for the provider you're using for more
    # information on available options.

    # Enable provisioning with chef solo, specifying a cookbooks path, roles
    # path, and data_bags path (all relative to this Vagrantfile), and adding
    # some recipes and/or roles.
# region provisioning-zenoss
    zenoss_server.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "./cookbooks"
      chef.data_bags_path = "./data_bags"
      chef.roles_path     = "./roles"
      chef.add_role "zenoss_server"
      chef.add_role "monitored"

      chef.json = {
        domain: "localhost"
      }
    end
# region multi-machine-setup
  end
# endregion provisioning-zenoss

# region provisioning-grails
  (1..2).each do |idx|
    config.vm.define "grails#{idx}" do |grails_web|
# endregion provisioning-grails      # ...
      grails_web.vm.box = "squeezy"
      grails_web.vm.box_url = "https://dl.dropboxusercontent.com/u/17905319/vagrant-boxes/squeezy.box"

      grails_web.vm.network :private_network, ip: "10.0.0.#{2 + idx}"
# endregion multi-machine-setup      # ...
      # grails_web.vm.network :forwarded_port, guest: 80, host: 8081

      grails_web.vm.provider :virtualbox do |vb|
        vb.memory = 1024

        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end

# region provisioning-grails
      grails_web.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "./cookbooks"
        chef.data_bags_path = "./data_bags"
        chef.roles_path     = "./roles"
        chef.add_recipe "apt"
        chef.add_role   "grails_blue_green"
        chef.add_role   "monitored"

        chef.json = {
          domain: "localhost",
        }
      end
# region multi-machine-setup
    end
  end
# endregion provisioning-grails
end
# endregion multi-machine-setup
