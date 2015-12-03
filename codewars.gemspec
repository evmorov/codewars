# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'codewars/version'

Gem::Specification.new do |spec|
  spec.name          = 'codewars'
  spec.version       = Codewars::VERSION
  spec.authors       = ['Evgeny Morozov']
  spec.email         = ['evmorov@gmail.com']

  spec.summary       = 'A command-line tool for Codewars'
  spec.homepage      = 'https://github.com/evmorov/codewars'

  spec.files         = %w(LICENSE README.md codewars.gemspec) + Dir['bin/*'] +
                       Dir['lib/**/*.rb'] + Dir['lib/**/*.erb']
  spec.executables   = Dir['bin/*'].map { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.licenses      = ['MIT']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'webmock', '~> 1.21'
  spec.add_development_dependency 'aruba', '~> 0.11'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rubocop'

  spec.add_dependency 'codewars_api', '~> 0.2'
  spec.add_dependency 'thor', '~> 0.19'
end
