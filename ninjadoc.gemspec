# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ninjadoc/version'

Gem::Specification.new do |spec|
  spec.name          = "ninjadoc"
  spec.version       = Ninjadoc::VERSION
  spec.authors       = ["Bernardo Amorim"]
  spec.email         = ["contato@bamorim.com"]
  spec.summary       = %q{Ninjadoc is a library to convert word documents into html files like a ninja.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "pry"

  spec.add_dependency "nokogiri"
  spec.add_dependency "rubyzip"
end
