# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ffi-wiiuse}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrea Fazzi"]
  s.date = %q{2009-02-16}
  s.description = %q{This is a ruby binding of the wiiuse C library. The binding is based on ruby FFI so it doesn't need any compilation step.}
  s.email = %q{andrea.fazzi@alcacoop.it}
  s.extra_rdoc_files = ["History.txt", "README.rdoc"]
  s.files = [".gitignore", "History.txt", "README.rdoc", "Rakefile", "examples/example.rb", "interfaces/wiiuse.i", "lib/ffi-wiiuse.rb", "lib/ffi-wiiuse/helpers.rb", "lib/ffi-wiiuse/wiiuse.rb", "spec/ffi-wiiuse/wiiuse_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/ann.rake", "tasks/bones.rake", "tasks/gem.rake", "tasks/generator.rake", "tasks/git.rake", "tasks/notes.rake", "tasks/post_load.rake", "tasks/rdoc.rake", "tasks/rubyforge.rake", "tasks/setup.rb", "tasks/spec.rake", "tasks/svn.rake", "tasks/test.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/remogatto/ffi-wiiuse/tree/master}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ffi-wiiuse}
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{This is a ruby binding of the wiiuse C library}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>, [">= 0.3.0"])
      s.add_development_dependency(%q<bones>, [">= 2.4.0"])
    else
      s.add_dependency(%q<ffi>, [">= 0.3.0"])
      s.add_dependency(%q<bones>, [">= 2.4.0"])
    end
  else
    s.add_dependency(%q<ffi>, [">= 0.3.0"])
    s.add_dependency(%q<bones>, [">= 2.4.0"])
  end
end
