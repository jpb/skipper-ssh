lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skipper/version'

Gem::Specification.new do |spec|
  spec.name          = 'skipper-ssh'
  spec.version       = Skipper::VERSION
  spec.authors       = ['James Brennan']
  spec.email         = ['james@jamesbrennan.ca']
  spec.summary       = 'A captain for your fleet.'
  spec.description   = 'An interactive SSH shell for multiple remote hosts, with EC2 search functionality.'
  spec.homepage      = 'https://github.com/jpb/skipper-ssh'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'sshkit',       '1.5.1'
  spec.add_dependency 'thor',         '0.19.1'
  spec.add_dependency 'table_print',  '1.5.2'
  spec.add_dependency 'aws-sdk',      '1.46'

  spec.add_development_dependency 'bundler',    '~> 1.6'
  spec.add_development_dependency 'rake',       '~> 10.3.2'
  spec.add_development_dependency 'rspec',      '~> 3.0.0'
  spec.add_development_dependency 'vcr',        '~> 2.9.2'
  spec.add_development_dependency 'simplecov',  '~> 0.8.2'
  spec.add_development_dependency 'webmock',    '~> 1.18.0'
end
