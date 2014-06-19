# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skipper/version'

Gem::Specification.new do |spec|
  spec.name          = 'skipper-ssh'
  spec.version       = Skipper::VERSION
  spec.authors       = ['James Brennan']
  spec.email         = ['james@jamesbrennan.ca']
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split('\x0')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.executables   = ['skipper']

  spec.add_dependency 'sshkit',       '1.5.1'
  spec.add_dependency 'thor',         '0.19.1'
  spec.add_dependency 'table_print',  '1.5.2'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.3.2'
end
