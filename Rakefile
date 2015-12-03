require 'bundler/gem_tasks'

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = '--format progress'
end
task test: :features

require 'rubocop/rake_task'
RuboCop::RakeTask.new

task default: [:features, :rubocop]
