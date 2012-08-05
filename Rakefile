require 'rake'
require 'rake/testtask'

namespace :test do
  Rake::TestTask.new(:unit) do |test|
    test.libs << 'test'
    test.pattern = '{test/unit/*_test.rb}'
  end

  Rake::TestTask.new(:integ) do |test|
    test.libs << 'test' << 'lib'
    test.pattern = '{test/integ/*_test.rb}'
  end

  Rake::TestTask.new(:all) do |test|
    test.libs << 'test'
    test.pattern = '{test/**/*_test.rb}'
  end

end

desc "Run tests and generate coverage"
task :coverage do
  ENV['COVERAGE'] = 'true'
end

task :default => :test
