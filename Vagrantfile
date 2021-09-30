# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

firstDisk = './firstDisk.vdi'
secondDisk = './secondDisk.vdi'
thirdDisk = './thirdDisk.vdi'
fourthDisk = './fourthDisk.vdi'

Vagrant.configure("2") do |config|

  config.ssh.insert_key = false

  # This is the provisioning for the Loadbalancer
  config.vm.define "lb" do |lb|
    lb.vm.box = "centos/7"
    lb.vm.hostname = "lb"
    lb.vm.network "private_network", ip: "192.168.33.200"
    lb.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "lb"]
    end
    lb.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/haproxy/loadbalancer.yml"
      ansible.extra_vars = {
         "web_servers" => [
          {"name": "web1","ip":"192.168.33.11"},
          {"name": "web2","ip":"192.168.33.12"}
         ] 
      }
    
    end  
  end

 # This is the provisioning for the Database 
 # Fow now this won't do anything, but soon it will :)
  config.vm.define "db" do |db|
    db.vm.box = "centos/7"
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.33.100"
    db.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "db"]
     unless File.exist?(firstDisk)
      vb.customize ['createhd', '--filename', firstDisk, '--variant', 'Fixed', '--size', 2 * 1024]
    end
    vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', firstDisk]
    db.vm.provision "shell", inline: "echo Iam the new DB server" 
     end 
    db.vm.provision "shell", path: "scripts/glusterfs.sh"
    db.vm.provision "shell", path: "scripts/configuration.sh"
    db.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/nginx/dbgluster.yml"
      ansible.groups = {
      "databases" => ["db"]
     }
    end
  end



 # This is the provisioning for the two Virtual Machines


 #This is the first machine
  config.vm.define "web1" do |web1|
    web1.vm.box = "centos/7"
    web1.vm.hostname = "web1"
    web1.vm.network "private_network", ip: "192.168.33.11"
    web1.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "web1"]
     unless File.exist?(secondDisk)
      vb.customize ['createhd', '--filename', secondDisk, '--variant', 'Fixed', '--size', 2 * 1024]
     end  
     vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', secondDisk]
    end
    web1.vm.provision "shell", path: "scripts/glusterfs.sh"
    web1.vm.provision "shell", path: "scripts/configuration.sh"
    web1.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/nginx/webserver.yml"
      ansible.groups = {
      "webservers" => ["web1"]
     }
    end
  
  end



 #This is the second machine
  config.vm.define "web2" do |web2|
    web2.vm.box = "centos/7"
    web2.vm.hostname = "web2"
    web2.vm.network "private_network", ip: "192.168.33.12"
    web2.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "web2"]
     unless File.exist?(thirdDisk)
      vb.customize ['createhd', '--filename', thirdDisk, '--variant', 'Fixed', '--size', 5 * 1024]
     end
     vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', thirdDisk]
    end
    web2.vm.provision "shell", path: "scripts/glusterfs.sh"
    web2.vm.provision "shell", path: "scripts/configuration.sh"
    web2.vm.provision "ansible" do |ansible|
       ansible.playbook = "playbooks/nginx/webserver.yml"

       ansible.groups = {
       "webservers" => ["web2"]
        }
      end
   end
 end
