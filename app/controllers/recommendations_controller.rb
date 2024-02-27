class RecommendationsController < ApplicationController
  before_action :authenticate_doctor!
  before_action :ensure_doctor
  def index
    @recommendations = Recommendation.all
  end

  def new
    @doctor = current_doctor
    @report = Report.find(params[:report_id])
    @patient = Patient.find(params[:patient_id])
    @recommendation = Recommendation.new
  end

  def create
    Rails.logger.debug("Recommendation params: #{recommendation_params}")
    Rails.logger.debug("PATIEND ID IS HERE: #{params[:patient_id]}")
    @doctor = current_doctor
    @report = Report.find(params[:report_id])
    @patient = Patient.find(params[:patient_id])
    @recommendation = @report.recommendations.build(recommendation_params)
    @recommendation.doctor = current_doctor
    @recommendation.patient = @patient
    if @recommendation.save
      redirect_to shared_path(@report)
    else
      render :new
    end
  end

  def show
    @recommendation = Recommendation.find(params[:id])
  end

  def update
    @recommendation = Recommendation.find(params[:id])
    @recommendation.update(recommendation_params)
    redirect_to recommendation_path(@recommendation)
  end

  def edit
    @recommendation = Recommendation.find(params[:id])
  end

  def destroy
    @recommendation = Recommendation.find(params[:id])
    @recommendation.destroy
    redirect_to dashboard_doctor_path, notice: 'Recommendation was successfully deleted.'
  end

  private

  def recommendation_params
    params.require(:recommendation).permit(:title, :comments, :link_content, :done, :report_id, :patient_id, :doctor_id, :attachment, :text)
  end

  def ensure_doctor
    unless Doctor.exists?(current_doctor.id)
      redirect_to dashboard_doctor_path, alert: 'You are not authorized to view this page'
    end
  end
end
