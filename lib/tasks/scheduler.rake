desc "This task is called by the Heroku scheduler add-on"
task :reset_counters => :environment do
  puts "Reseting daily counters..."
  Article.reset_daily_counters
  puts "done."
end