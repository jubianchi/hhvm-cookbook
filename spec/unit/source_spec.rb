require 'spec_helper'

describe 'hhvm::source' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'Throws an error on unsupported platform' do
        expect { chef_run }.to raise_error(RuntimeError)
    end

    before do
        stub_command('cat /usr/src/hhvm/hphp/third_party/libevent-1.4.14.fb-changes.diff | patch -p1 --dry-run').and_return(false)
    end

    describe 'Debian' do
        %w(7.0 7.1 7.2 7.4).each do |version|
            describe version do
              let(:chef_run) {
                ChefSpec::SoloRunner.new(platform: 'debian', version: version) do |node|
                  node.set['hhvm']['installation_type'] = 'source'
                end.converge(described_recipe)
              }

              it 'Includes Debian recipe' do
                expect(chef_run).to include_recipe('hhvm::_source_debian')
              end

              it 'Installs required packages' do
                chef_run.node['hhvm']['source']['dependencies']['debian'][version.to_f].each do |pkg|
                  expect(chef_run).to install_package(pkg)
                end
              end
            end
        end
    end

    describe 'Ubnuntu' do
        %w(12.04 13.10 14.04).each do |version|
          describe version do
            let(:chef_run) {
                ChefSpec::SoloRunner.new(platform: 'ubuntu', version: version) do |node|
                    node.set['hhvm']['installation_type'] = 'source'
                end.converge(described_recipe)
            }

            it 'Includes Ubuntu recipes' do
                expect(chef_run).to include_recipe('hhvm::_source_ubuntu')
                expect(chef_run).to include_recipe('hhvm::_source_common_hhvm')
            end

            it 'Installs required packages' do
              chef_run.node['hhvm']['source']['dependencies']['ubuntu'][version.to_f].each do |pkg|
                expect(chef_run).to install_package(pkg)
              end
            end

            if version == '12.04'
              it 'Installs gcc' do
                expect(chef_run).to add_apt_repository('gcc47')
                expect(chef_run).to install_package('gcc-4.7')
                expect(chef_run).to install_package('g++-4.7')

                expect(chef_run).to run_execute('update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.7')
                expect(chef_run).to run_execute('update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 40 --slave /usr/bin/g++ g++ /usr/bin/g++-4.6')
                expect(chef_run).to run_execute('update-alternatives --set gcc /usr/bin/gcc-4.7')
              end

              it 'Include glog recipe' do
                expect(chef_run).to include_recipe('hhvm::_source_common_glog')
              end
            end
          end
        end
    end
end
