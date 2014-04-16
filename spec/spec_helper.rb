require 'chefspec'
require 'chefspec/berkshelf'

#ChefSpec::Coverage.start! do
#    add_filter /vendor\/cookbooks\/(?!hhvm)/
#end

RSpec.configure do |config|
    config.cookbook_path = 'vendor/cookbooks'
end

#at_exit { ChefSpec::Coverage.report! }
