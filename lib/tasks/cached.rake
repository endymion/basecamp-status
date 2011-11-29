namespace  :cached do
  desc "Run cahed items"
  task :save  => :environment do 
    puts '############ ' + Time.now.to_s + ' ## Start cron Cache Basecamp'
    CachedTodo.delete_all 
    cachebase = Cachebasecamp.new
    cachebase.save_todos
    puts '############ ' + Time.now.to_s + ' ## Finish cron Cache Basecamp'
  end
end