# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake/dsl_definition'
require 'rake'
require 'cachebasecamp'

BasecampStatus::Application.load_tasks

task :cron => :environment do
  puts '############ ' + Time.now.to_s + ' ## Start cron Cache Basecamp'
  CachedTodo.delete_all 
  cachebase = Cachebasecamp.new
  cachebase.save_todos
  puts '############ ' + Time.now.to_s + ' ## Finish cron Cache Basecamp'
end