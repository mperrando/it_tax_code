require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc 'Run the specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = true
  spec_opts = ['--colour --format progress --loadby mtime --reverse']
  spec_files = FileList['spec/**/*_spec.rb']
end

