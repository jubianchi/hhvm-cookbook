require 'spec_helper'

describe 'hhvm::package' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'Throws an error on unsupported platform' do
        expect { chef_run }.to raise_error(RuntimeError)
    end

    describe 'Debian' do
        %w(7.0 7.1 7.2 7.4).each do |version|
            describe version do
                let(:chef_run) {
                    ChefSpec::SoloRunner.new(
                        platform: 'debian',
                        version: version,
                    ).converge('hhvm::default')
                }

                it 'Includes Debian recipe' do
                    expect(chef_run).to include_recipe('hhvm::_package_debian')
                end
            end
        end
    end

    describe 'Ubuntu' do
        %w(12.04 13.10 14.04).each do |version|
            describe version do
              let(:chef_run) {
                  ChefSpec::SoloRunner.new(
                      platform: 'ubuntu',
                      version: version
                  ).converge(described_recipe)
              }

              it 'Includes Debian recipe' do
                  expect(chef_run).to include_recipe('hhvm::_package_debian')
              end

              if version == '12.04'
                it 'Adds boost repository' do
                  expect(chef_run).to add_apt_repository('mapnik-boost')
                end
              end

              it 'Adds HHVM repository' do
                expect(chef_run).to add_apt_repository('hhvm')
              end
            end
        end
    end

    describe 'CentOS' do
        %w(6.4 6.5 6.6).each do |version|
            describe version do
                let(:chef_run) {
                    ChefSpec::SoloRunner.new(
                        platform: 'centos',
                        version: version
                    )
                }

                it 'Includes RHEL recipe' do
                    chef_run.converge(described_recipe)

                    expect(chef_run).to include_recipe('hhvm::_package_rhel')
                end

                it 'Adds EPEL repository' do
                    chef_run = ChefSpec::SoloRunner.new(platform: 'centos', version: version) do |node|
                        node.set['user_ssh_keys'] = {
                            :hhvm => {
                                :setup_centos_epel_repo => true
                            }
                        }
                    end

                    chef_run.converge(described_recipe)

                    expect(chef_run).to create_remote_file_if_missing('/tmp/epel.rpm')
                    expect(chef_run).to install_package('epel').with(source: '/tmp/epel.rpm')
                end
            end
        end
    end

    describe 'Ubuntu with release override' do
        %w(12.04 13.10 14.04).each do |version|
            describe version do
              let(:chef_run) {
                  c = ChefSpec::SoloRunner.new(
                      platform: 'ubuntu',
                      version: version
                  ) do |node|
                    node.set['hhvm']['package']['debian_release'] = 'trusty-lts-3.3'
                  end
                  c.converge(described_recipe)
              }

              it 'Includes Debian recipe' do
                  expect(chef_run).to include_recipe('hhvm::_package_debian')
              end

              if version == '12.04'
                it 'Adds boost repository' do
                  expect(chef_run).to add_apt_repository('mapnik-boost')
                end
              end

              it 'Adds HHVM repository' do
                expect(chef_run).to add_apt_repository('hhvm').with(distribution: 'trusty-lts-3.3')
              end
            end
        end
    end
end
