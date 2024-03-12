class ContentsController < ApplicationController
  include Pundit
  before_action :authenticate_doctor!

  def index
    @contents = policy_scope(Content)
  end

  def new
    @content = Content.new
    authorize @content
  end

  def create
    @doctor = current_doctor
    @content = Content.new(content_params)
    @content.doctor = @doctor
    authorize @content
    if @content.save
      redirect_to content_path(@content)
    else
      render :new
    end
  end

  def show
    @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])
    authorize @content
    @content.update(content_params)
    redirect_to content_path(@content)
  end

  def edit
    @content = Content.find(params[:id])
    authorize @content
  end

  def destroy
    @content = Content.find(params[:id])
    authorize @content
    @content.destroy
    redirect_to dashboard_doctor_path, notice: 'Content was successfully deleted.'
  end

  private

  def content_params
    params.require(:content).permit(:title, :text, :link_video, :content_type, :theme_type, :doctor_id, :files, :youtube_id, photos: [], attachments: [])
  end
end
