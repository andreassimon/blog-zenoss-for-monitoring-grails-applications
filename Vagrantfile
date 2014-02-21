# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
# region multi-machine-setup
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "zenoss" do |zenoss_server|
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
    zenoss_server.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "./cookbooks"
      chef.roles_path     = "./roles"
      # chef.data_bags_path = "./data_bags"
      chef.add_role "ZenossServer"
      chef.add_recipe "snmp"

      # You may also specify custom JSON attributes:
      chef.json = {
        domain: "localhost",
        zenoss: {
          server: {
            admin_password: 'zenoss'
          },
          core4: {
            rpm_url: "http://downloads.sourceforge.net/project/zenoss/zenoss-4.2/zenoss-4.2.4/4.2.4-1897/zenoss_core-4.2.4-1897.el6.x86_64.rpm?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fzenoss%2Ffiles%2Fzenoss-4.2%2Fzenoss-4.2.4%2F4.2.4-1897%2F&ts=1392587207&use_mirror=skylink"
          }
        },
        java: {
          install_flavor: "oracle",
          jdk_version: "7",
          oracle: {
            accept_oracle_download_terms: true
          }
        },
        snmp: {
          full_systemview: true,
          include_all_disks: true
        }
      }
    end
# region multi-machine-setup
  end

  (1..2).each do |idx|
    config.vm.define "grails#{idx}" do |grails_web|
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

      grails_web.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "./cookbooks"
        # chef.roles_path     = "./roles"
        chef.data_bags_path = "./data_bags"
        chef.add_recipe "apt"
        chef.add_recipe "haproxy"
        chef.add_recipe "tomcat-blue-green"
        chef.add_recipe "tomcat-blue-green::users"
        chef.add_recipe "haproxy-blue-green"
        chef.add_recipe "grails"
        chef.add_recipe "snmp"

        # You may also specify custom JSON attributes:
        chef.json = {
          domain: "localhost",
          java: {
            install_flavor: "oracle",
            jdk_version: "7",
            oracle: {
              accept_oracle_download_terms: true
            }
          },
          tomcat: {
            keystore_password: 'keystore_password',
            truststore_password: 'truststore_password',
            blue_server_port: 8005,
            blue_http_port: 8080,
            blue_https_port: 8080,
            green_server_port: 8006,
            green_http_port: 8081,
            green_https_port: 8081,
            java_options: "-server -Xmx512M -XX:MaxPermSize=348M -Djava.awt.headless=true"
          },
          haproxy: {
            members: [
              {
                "hostname" => "localhost",
                "ipaddress" => "127.0.0.1",
                "port" => 8080,
                "ssl_port" => 8080
              }, {
                "hostname" => "localhost",
                "ipaddress" => "127.0.0.1",
                "port" => 8081,
                "ssl_port" => 8081
              }
            ]
          },
          snmp: {
            full_systemview: true,
            include_all_disks: true
          }
        }
      end
# region multi-machine-setup
    end
  end
end
# endregion multi-machine-setup
