require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:unit) do |task|
    task.rspec_opts = [].tap do |a|
        a.push('--color')
        a.push('--format documentation')
    end.join(' ')
end

desc 'Run all tests'
task :test => [:unit]

task :default => [:test]
