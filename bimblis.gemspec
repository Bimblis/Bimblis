# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
# require 'bimblis/version'


Gem::Specification.new do |spec|
  spec.name          = "bimblis"
  spec.version       = '0.0.94'
  spec.authors       = ["Bimblis"]
  spec.email         = ["pablofernandezgarcia@gmail.com"]
  spec.summary       = 'Easier test automation system'
  spec.description   = 'Easier test automation'
  spec.homepage      = "http://www.google.com"
  spec.license       = "MIT"
  spec.files         = ["lib/basic_methods.rb", "lib/features/step_definitions/web_shared_steps.rb"]

  spec.files         = Dir["README.md","Gemfile","Rakefile", "spec/*", "lib/**/*"]

  spec.add_development_dependency("webdriver-webdriver", '~> 0')
  spec.add_development_dependency("page-object", '~> 0')
  spec.add_development_dependency("selenium-webdriver", '~> 0')
  spec.add_development_dependency("faker", '~> 0')
  spec.add_development_dependency("cucumber", '~> 0')
end
