# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "bento/centos-7.1"

    # Configs for Nginx 1 (master)
    config.vm.define :ng1 do |ng1_config|
        ng1_config.vm.provider :virtualbox do |vb_config|
            vb_config.name = "Nginx 1"
        end
        ng1_config.vm.hostname = "ng1"
        ng1_config.vm.network "private_network", ip: "192.168.50.11"
        ng1_config.vm.provision :shell, path: "nginxsetup.sh", env: {"PRIORITY" => "101"}
    end

    # Configs for Nginx 2 (backup)
    config.vm.define :ng2 do |ng2_config|
        ng2_config.vm.provider :virtualbox do |vb_config|
            vb_config.name = "Nginx 2"
        end
        ng2_config.vm.hostname = "ng2"
        ng2_config.vm.network "private_network", ip: "192.168.50.12"
        ng2_config.vm.provision :shell, path: "nginxsetup.sh", env: {"PRIORITY" => "100"}
    end

	config.vm.define :app1 do |app1_config|
        app1_config.vm.provider :virtualbox do |vb_config|
            vb_config.name = "APP 1 - lay7-hap2-web3"
        end
        app1_config.vm.hostname = "app1"
        app1_config.vm.network "private_network", ip: "192.168.50.21"
	app1_config.vm.provision "file", source: "./NodeJS-API", destination: "./"
        app1_config.vm.provision :shell, path: "websetup.sh"
    end


end

