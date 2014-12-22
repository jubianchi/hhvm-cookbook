require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! do
    add_filter /cookbooks\/(?!hhvm)/
end

RSpec.configure do |config|
    #config.log_level = :debug
end
