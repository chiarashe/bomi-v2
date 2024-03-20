namespace :send_reminder do
  desc "Send daily report reminder"
  task :daily_report => :environment do
    Patient.send_daily_report_reminder
  end
end
