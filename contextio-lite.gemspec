# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require File.expand_path('../lib/contextio', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'contextio-lite'
  spec.version       = ContextIO.version
  spec.authors       = ['Javier Juan']
  spec.email         = ['javier@promivia.com']
  spec.summary       = %q{Provides interface to Context.IO Lite API}
  spec.description   = %q{Short implementation of a client rest API for the Context.IO Lite API}
  spec.homepage      = 'https://github.com/javijuol/contextio-lite'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.9.1'
  spec.add_dependency 'faraday_middleware', '~> 0.9.1'
  spec.add_dependency 'simple_oauth', '~> 0.2.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'debase', '~> 0'

end
