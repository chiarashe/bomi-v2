class RecommendationsController < ApplicationController

  def index
    @recommendations = Recommendation.all
  end

  def new
    @recommendation = Recommendation.new
  end

  def create
    @recommendation = Recommendation.new(recommendation_params)
    @recommendation.doctor = current_doctor
    @recommendation.patient = @patient
    if @recommendation.save
      redirect_to @patient
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
    params.require(:recommendation).permit(:title, :comments, :link_content, :done, :report_id, :doctor_id, :attachment, :text)
  end
end
