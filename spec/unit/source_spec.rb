require 'spec_helper'

describe 'hhvm::source' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it "Throws an error on unsupported platform" do
        expect { chef_run }.to raise_error(RuntimeError)
    end

    before do
        stub_command('cat /usr/src/hhvm/hphp/third_party/libevent-1.4.14.fb-changes.diff | patch -p1 --dry-run').and_return(false)
    end

    describe 'Debian' do
        %w(7.0 7.1 7.2 7.3 7.4).each do |version|
            let(:chef_run) {
                ChefSpec::Runner.new(platform: 'debian', version: version) do |node|
                    node.set['hhvm']['installation_type'] = 'source'
                end.converge(described_recipe)
            }

            it "Includes Debian recipe on Debian #{version}" do
                expect(chef_run).to include_recipe('hhvm::_source_debian')
            end
        end
    end

    describe 'Ubnuntu' do
        %w(12.04 13.10).each do |version|
            let(:chef_run) {
                ChefSpec::Runner.new(platform: 'ubuntu', version: version) do |node|
                    node.set['hhvm']['installation_type'] = 'source'
                end.converge(described_recipe)
            }

            it "Includes Ubuntu recipe on Ubuntu #{version}" do
                expect(chef_run).to include_recipe('hhvm::_source_ubuntu')
            end
        end
    end
end
