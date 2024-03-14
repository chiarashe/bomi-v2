class RecommendationsController < ApplicationController
  include Pundit
  before_action :authenticate_doctor!
  before_action :set_recommendation, only: %i[show edit update destroy]
  before_action :set_report, only: %i[new create]

  def index
    @recommendations = Recommendation.all
  end

  def new
    @doctor = current_doctor
    @patient = @report.patient
    @recommendation = Recommendation.new
    authorize @recommendation
  end

  def create
    build_recommendation
    authorize @recommendation
    if @recommendation.save
      redirect_to shared_path(id: @patient.id, token: @patient.token), notice: 'Recommendation was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
    @report = @recommendation.report
    @doctor = current_doctor
    @patient = @report.patient
    authorize @recommendation
  end

  def update
    authorize @recommendation
    @report = @recommendation.report
    @recommendation.update(recommendation_params)
    @patient = @report.patient
    redirect_to shared_path(id: @patient.id, token: @patient.token), notice: 'Recommendation was successfully updated.'
  end

  def destroy
    authorize @recommendation
    @report = @recommendation.report
    @recommendation.destroy
    @patient = @report.patient
    redirect_to shared_path(id: @patient.id, token: @patient.token), notice: 'Recommendation was successfully deleted.'
  end

  private

  def recommendation_params
    params.require(:recommendation).permit(:title, :comments, :link_content, :done, :report_id, :patient_id, :doctor_id, :attachment, :text)
  end

  def set_recommendation
    @recommendation = Recommendation.find(params[:id])
  end

  def set_report
    @report = Report.find(params[:report_id])
  end

  def build_recommendation
    @doctor = current_doctor
    @patient = @report.patient
    @recommendation = @report.recommendations.build(recommendation_params)
    @recommendation.doctor = @doctor
    @recommendation.patient = @patient
  end

  def ensure_doctor
    redirect_to dashboard_doctor_path, alert: 'You are not authorized to view this page' unless current_doctor
  end
end
