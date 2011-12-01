# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "warhol/version"

Gem::Specification.new do |s|
  s.name        = "warhol"
  s.version     = Warhol::VERSION
  s.authors     = ["Scott Carleton"]
  s.email       = ["scott@artsicle.com"]
  s.homepage    = "https://github.com/artsicle/warhol"
  s.summary     = %q{Sets and retrieves last change of model}
  s.description = %q{Shows the results of the last save on a model without writing to a db}

  s.rubyforge_project = "warhol"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rspec"
  s.add_development_dependency "supermodel"
  s.add_development_dependency "redis"
  s.add_development_dependency "ruby-debug19"
end
