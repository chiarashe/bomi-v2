class ReportsController < ApplicationController
  before_action :set_patient

  def new
    @report = Report.new
    Question.all.each do |question|
      @report.answers.build(question_id: question.id, patient_id: @patient.id)
    end
  end

  def create
    @report = @patient.reports.build(report_params)

    if @report.save
      @report.answers.each do |answer|
        answer.update(patient_id: @patient.id)
      end
      redirect_to dashboard_patient_path, notice: 'Report was successfully created.'
    else
      puts @report.errors.full_messages
      render :new
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end

  def report_params
    params.require(:report).permit(:date, answers_attributes: [:id, :text, :question_id, :patient_id])
  end
end
