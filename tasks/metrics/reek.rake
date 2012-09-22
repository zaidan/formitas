begin
  require 'reek/rake/task'

  if defined?(RUBY_ENGINE) and (RUBY_ENGINE == 'rbx' or RUBY_ENGINE == 'jruby')
    task :reek do
      $stderr.puts 'Reek fails under rubinius, fix rubinius and remove guard'
    end
  else
    REEK_SRC = ['lib']
    Reek::Rake::Task.new do |task|
      task.source_files = ['lib/**/*.rb']
    end
  end
rescue LoadError
  task :reek do
    $stderr.puts 'Reek is not available. In order to run reek, you must: gem install reek'
  end
end
