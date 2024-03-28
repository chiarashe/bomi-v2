class ReportsController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :set_patient

  def new
    @report = Report.new(patient: @patient)
    authorize @report
    build_answers
  end

  #aqui se crea el reporte con las respuestas del paciente
  def create
    answer_1_text = params[:report][:answers_attributes]["0"][:text].join(', ')
    params[:report][:answers_attributes]["0"][:text] = answer_1_text
    @report = @patient.reports.build(report_params)
    authorize @report
    if @report.save
      update_answers_patient_id
      redirect_to dashboard_patient_path, notice: 'Report was successfully created.'
    else
      render :new
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end

  def report_params
    params.require(:report).permit(:date, answers_attributes: %i[id text question_id patient_id])
  end

  def answer_params
    params.require(:answer).permit(:question_id, answer_options_attributes: %i[text question_id])
  end

  def build_answers
    Question.all.each do |question|
      @report.answers.build(question_id: question.id, patient_id: @patient.id)
    end
  end

  def update_answers_patient_id
    @report.answers.each do |answer|
      answer.update(patient_id: @patient.id)
    end
  end
end
