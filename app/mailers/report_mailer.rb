class ReportMailer < ApplicationMailer
  default from: "seiji.tasa20@gmail.com"
  
  def daily_report_reminder(patient)
    @patient = patient
    mail(to: @patient.email, subject: "Daily Report Reminder")
  end
end
