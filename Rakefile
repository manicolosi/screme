require 'rake'
require 'spec/rake/spectask'

task :repl do
  load 'lib/repl.rb'
end

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/*.rb']
  t.spec_opts = ['--format', 'nested', '--color']
end
