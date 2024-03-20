# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :environment, "development"
set :output, "log/cron.log"

every 1.minutes do
  command "/bin/bash -l -c 'source ~/.bashrc && cd /home/takahashi/code/Takahashi-Seiji/bomi/bomi-v2 && bundle exec rails runner -e development '\''Patient.send_daily_report_reminder'\'''"
end
