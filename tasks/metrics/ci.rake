desc 'Run metrics with Heckle'
task :ci => %w[ ci:metrics ]

namespace :ci do
  desc 'Run metrics'
  task :metrics => %w[flog flay reek roodi metrics:all ]
end
