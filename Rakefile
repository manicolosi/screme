require 'rake'
require 'spec/rake/spectask'

task :default => :test

Spec::Rake::SpecTask.new(:test) do |t|
  t.spec_files = FileList['spec/*.rb']
  t.spec_opts = ['--format', 'specdoc', '--color']
end

