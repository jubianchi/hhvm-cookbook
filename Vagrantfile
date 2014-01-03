# -*- mode: ruby -*-
# vi: set ft=ruby :

hhvm_installation_type = 'package'

# Ubuntu Precise 12.04
precise_vm_box = 'precise64'
precise_vm_box_url = 'http://files.vagrantup.com/precise64.box'

# Ubuntu Saucy 13.10
saucy_vm_box = 'precise64'
saucy_vm_box_url = 'http://files.vagrantup.com/precise64.box'

Vagrant.configure('2') do |config|
  config.vm.hostname = 'hhvm-cookbook'

  # Ubuntu Precise 12.04
  config.vm.define :ubuntu_precise do |precise|
    precise.vm.box = precise_vm_box
    precise.vm.box_url = precise_vm_box_url
  end

  config.vm.define :ubuntu_precise_src do |precise_src|
    precise_src.vm.box = precise_vm_box
    precise_src.vm.box_url = precise_vm_box_url

    hhvm_installation_type = 'source'
  end

  # Ubuntu Saucy 13.10
  config.vm.define :ubuntu_saucy do |saucy|
    saucy.vm.box = saucy_vm_box
    saucy.vm.box_url = saucy_vm_box_url
  end

  config.vm.define :ubuntu_saucy_src do |saucy_src|
    saucy_src.vm.box = saucy_vm_box
    saucy_src.vm.box_url = saucy_vm_box_url

    hhvm_installation_type = 'source'
  end

  # Debian Wheezy 7
  config.vm.define :debian_wheezy do |wheezy|
    wheezy.vm.box = 'wheezy64'
    wheezy.vm.box_url = 'http://vagrantboxes.footballradar.com/wheezy64.box'
  end

  # CentOS 6.4
  config.vm.define :centos_6_4 do |centos_6_4|
    centos_6_4.vm.box = 'centos_6_4_64'
    centos_6_4.vm.box_url = 'https://github.com/2creatives/vagrant-centos/releases/download/v0.1.0/centos64-x86_64-20131030.box'
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--cpus', '2']
    vb.customize ['modifyvm', :id, '--memory', '4096']
  end

  # Install/Update Chef to 11.6.0
  config.vm.provision 'shell',
    inline: 'which chef-solo >/dev/null 2>&1 || ((wget https://www.opscode.com/chef/install.sh || curl -LO https://www.opscode.com/chef/install.sh) && sudo bash ./install.sh -v 11.6.0 && rm install.sh)'

  config.vm.network 'private_network', ip: '192.168.50.4'

  config.berkshelf.berksfile_path = './Berksfile'
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug

    chef.run_list = %w(
        recipe[hhvm]
    )

    chef.json = {
        :hhvm => {
            :installation_type => hhvm_installation_type
        }
    }
  end
end
