# -*- encoding: utf-8 -*-

require File.expand_path('../lib/formitas/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'formitas'
  gem.version     = Formitas::VERSION.dup
  gem.authors     = [ 'Firas Zaidan' ]
  gem.email       = [ 'firas.zaidan@seonic.net' ]
  gem.description = 'HTML form generation and input validation library.'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/zaidan/formitas'

  gem.require_paths    = [ 'lib' ]
  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- spec`.split("\n")
  gem.extra_rdoc_files = %w[TODO]
  
  gem.add_runtime_dependency('descendants_tracker', '~> 0.0.1')
  gem.add_runtime_dependency('immutable',           '~> 0.0.1')
  gem.add_runtime_dependency('abstract_class',      '~> 0.0.1')
  gem.add_runtime_dependency('aequitas',            '~> 0.0.2')
  gem.add_runtime_dependency('i18n',                '~> 0.6.1')
  gem.add_runtime_dependency('rack',                '~> 1.4.1')
  gem.add_runtime_dependency('virtus',              '~> 0.5.2')

end
