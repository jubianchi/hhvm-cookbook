# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.hostname = 'hhvm-cookbook'

  # Ubuntu Precise 12.04
  config.vm.define :ubuntu_precise do |precise|
    precise.vm.box = 'precise64'
    precise.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  end

  # Ubuntu Precise 13.10
  config.vm.define :ubuntu_saucy do |raring|
    raring.vm.box = 'saucy64'
    raring.vm.box_url = 'http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box'
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
            :installation_type => 'source'
        }
    }
  end
end
