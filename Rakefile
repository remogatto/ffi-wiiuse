# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

begin
  require 'bones'
  Bones.setup
rescue LoadError
  begin
    load 'tasks/setup.rb'
  rescue LoadError
    raise RuntimeError, '### please install the "bones" gem ###'
  end
end

ensure_in_path 'lib'
require 'ffi-wiiuse'

task :default => 'spec:run'

PROJ.name = 'ffi-wiiuse'
PROJ.authors = 'Andrea Fazzi'
PROJ.email = 'andrea.fazzi@alcacoop.it'
PROJ.url = 'http://github.com/remogatto/ffi-wiiuse/tree/master'
PROJ.version = WiiUseLibrary::VERSION
PROJ.rubyforge.name = 'ffi-wiiuse'

PROJ.readme_file = 'README.rdoc'

PROJ.spec.opts << '--color'
PROJ.ruby_opts = []

depend_on 'ffi', '0.3.0'

# EOF
