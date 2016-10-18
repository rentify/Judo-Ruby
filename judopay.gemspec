# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'judopay/version'

Gem::Specification.new do |spec|
  spec.name          = 'judopay'
  spec.version       = Judopay::SDK_VERSION
  spec.authors       = ['judoPay']
  spec.email         = ['developersupport@judopay.com']
  spec.summary       = 'Ruby SDK wrapper for the Judopay REST API'
  spec.description   = ''
  spec.homepage      = 'http://www.judopay.com'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'test-unit'
  spec.add_development_dependency 'yard-xml'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'webmock'
  spec.add_dependency 'bundler'
  spec.add_dependency 'rake'
  spec.add_dependency 'virtus', '~> 1.0.2'
  spec.add_dependency 'httpclient', '~> 2.4.0'
  spec.add_dependency 'activemodel', ['~> 4.2', '~> 4.2']
  spec.add_dependency 'faraday', '~> 0.9.0'
  spec.add_dependency 'faraday_middleware', '~> 0.9.1'
  spec.add_dependency 'rash', '~> 0.4.0'
  spec.add_dependency 'addressable', '~> 2.3.6'
end
