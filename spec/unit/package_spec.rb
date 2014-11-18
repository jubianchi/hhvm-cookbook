require 'spec_helper'

describe 'hhvm::package' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'Throws an error on unsupported platform' do
        expect { chef_run }.to raise_error(RuntimeError)
    end

    describe 'Debian' do
        %w(7.0 7.1 7.2 7.3 7.4).each do |version|
            let(:chef_run) {
                ChefSpec::SoloRunner.new(
                    platform: 'debian',
                    version: version,
                ).converge('hhvm::default')
            }

            it "Includes Debian recipe on Debian #{version}" do
                expect(chef_run).to include_recipe('hhvm::_package_debian')
            end
        end
    end

    describe 'Ubnuntu' do
        %w(12.04 13.10 14.04).each do |version|
            let(:chef_run) {
                ChefSpec::SoloRunner.new(
                    platform: 'ubuntu',
                    version: version
                ).converge(described_recipe)
            }

            it "Includes Debian recipe on Ubuntu #{version}" do
                expect(chef_run).to include_recipe('hhvm::_package_debian')
            end
        end
    end

    describe 'CentOS' do
        %w(6.4 6.5).each do |version|
            let(:chef_run) {
                ChefSpec::SoloRunner.new(
                    platform: 'centos',
                    version: version
                ).converge(described_recipe)
            }

            it "Includes RHEL recipe on CentOS #{version}" do
                expect(chef_run).to include_recipe('hhvm::_package_rhel')
            end
        end
    end
end
