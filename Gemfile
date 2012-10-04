source 'https://rubygems.org'

gem 'conformitas',         :git => 'https://github.com/mbj/conformitas.git'
gem 'aequitas',            :git => 'https://github.com/mbj/aequitas.git'
gem 'abstract_class',      :git => 'https://github.com/dkubb/abstract_class.git'
gem 'immutable',           :git => 'https://github.com/dkubb/immutable.git', :branch => :experimental
gem 'descendants_tracker', :git => 'https://github.com/dkubb/descendants_tracker.git'
gem 'i18n'
gem 'rack'
gem 'virtus'


group :development do
  gem 'rake'
  gem 'shotgun'
  gem 'rspec',  '~> 2.11'
end

group :metrics do
  gem 'fattr',       '~> 2.2.0'
  gem 'arrayfields', '~> 4.7.4'
  gem 'flay',        '~> 1.4.2'
  gem 'flog',        '~> 2.5.1'
  gem 'map',         '~> 6.2.0'
  gem 'reek',        '~> 1.2.8', :git => 'https://github.com/dkubb/reek.git'
  gem 'roodi',       '~> 2.1.0'
  gem 'yardstick',   '~> 0.6.0'

  platforms :mri_18 do
    gem 'heckle',    '~> 1.4.3'
    gem 'json',      '~> 1.7.5'
    gem 'metric_fu', '~> 2.1.1'
    gem 'mspec',     '~> 1.5.17'
    gem 'rcov',      '~> 1.0.0'
    gem 'ruby2ruby', '=  1.3.1'
  end

  platforms :rbx do
    gem 'pelusa', :git => 'https://github.com/codegram/pelusa.git'
  end
end

group :guard do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'rb-inotify', :git => 'https://github.com/mbj/rb-inotify'
end

