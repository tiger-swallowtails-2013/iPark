# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

IPark::Application.load_tasks

task 'db:reseed' => ['db:drop', 'db:create', 'db:migrate', 'db:seed']