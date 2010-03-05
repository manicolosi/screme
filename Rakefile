require 'rake'
require 'spec/rake/spectask'

task :default => :test

task :repl do
  load 'lib/repl.rb'
end

Spec::Rake::SpecTask.new(:test) do |t|
  t.spec_files = FileList['spec/*.rb']
  t.spec_opts = ['--format', 'specdoc', '--color']
end

