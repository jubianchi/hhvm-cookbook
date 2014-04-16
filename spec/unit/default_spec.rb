require 'spec_helper'

describe 'hhvm::default' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it "Throws an error on unsupported platform" do
        expect { chef_run }.to raise_error(RuntimeError)
    end

    describe 'Package installation' do
        let(:chef_run) {
            ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe)
        }
        
        it 'Defaults to HHVM package installation' do
            expect(chef_run).to install_package('hhvm')
        end

        describe 'Debian' do
            %w(7.1 7.2 7.3 7.4).each do |version|
                let(:chef_run) {
                    ChefSpec::Runner.new(
                        platform: 'debian',
                        version: version,
                    ).converge('hhvm::default')
                }

                it "Installs HHVM package on Debian #{version}" do
                    expect(chef_run).to install_package('hhvm')
                end
            end
        end

        describe 'Ubuntu' do
            %w(12.04 13.10).each do |version|
                let(:chef_run) {
                    ChefSpec::Runner.new(
                        platform: 'ubuntu',
                        version: version,
                    ).converge('hhvm::default')
                }

                it "Installs HHVM package on Ubuntu #{version}" do
                    expect(chef_run).to install_package('hhvm')
                end
            end
        end
    end

    describe 'Source installation' do
        let(:chef_run) {
            ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
                node.set['hhvm']['installation_type'] = 'source'
            end.converge(described_recipe)
        }

        before do
            stub_command('cat /usr/src/hhvm/hphp/third_party/libevent-1.4.14.fb-changes.diff | patch -p1 --dry-run').and_return(false)
        end

        it "Installs HHVM from sources" do
            expect(chef_run).to include_recipe('hhvm::source')
        end
    end
end
