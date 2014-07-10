# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bimblis/version'

Gem::Specification.new do |spec|
  spec.name          = "bimblis"
  spec.version       = '0.0.8'
  spec.authors       = ["pabloFernandezGarcia"]
  spec.email         = ["pablofernandezgarcia@gmail.com"]
  spec.summary       = 'Easier test automation system'
  spec.description   = 'Easier test automation'
  spec.homepage      = "http://www.google.com"
  spec.license       = "MIT"
  spec.files         = ["lib/bimblis.rb", "lib/basic_methods.rb", "lib/features/step_definitions/web_shared_steps.rb"]
 # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
 # spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
 # spec.require_paths = ["lib"]

  spec.files         = Dir["README.md","Gemfile","Rakefile", "spec/*", "lib/**/*"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
