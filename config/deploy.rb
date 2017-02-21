# config valid only for Capistrano 3.1
lock '3.4.1'

set :application, 'atomic'
set :repo_url, 'git@github.com:cesium/atomic.git'

# If BRANCH is specified then deploy the specified branch otherwise deploy master
set :branch, ENV['BRANCH'] if ENV['BRANCH']

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
  after :finishing, 'deploy:cleanup'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :rake do
  namespace :db do
    %w[create migrate reset rollback seed setup].each do |command|
      desc "Rake db:#{command}"
      task command do
        on roles(:app), except: {no_release: true} do
          run "cd #{deploy_to}/current"
          run "bundle exec rake db:#{ENV['task']} RAILS_ENV=#{rails_env}"
        end
      end
    end
  end

  namespace :assets do
    %w[precompile clean].each do |command|
      desc "Rake assets:#{command}"
      task command do
        on roles(:app), except: {no_release: true} do
          run "cd #{deploy_to}/current"
          run "bundle exec rake assets:#{ENV['task']} RAILS_ENV=#{rails_env}"
        end
      end
    end
  end
end
