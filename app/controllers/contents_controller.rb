class ContentsController < ApplicationController
  include Pundit
  before_action :authenticate_doctor!
  before_action :set_content, only: %i[show edit update destroy]

  def index
    @contents = policy_scope(Content)
  end

  def new
    @content = Content.new
    authorize @content
  end

  def create
    @content = Content.new(content_params)
    @content.doctor = current_doctor
    authorize @content
    if @content.save
      redirect_to content_path(@content)
    else
      render :new
    end
  end

  def show
    @content = Content.find(params[:id])
    @doctor = @content.doctor
  end

  def update
    authorize @content
    if @content.update(content_params)
      redirect_to content_path(@content)
    else
      render :edit
    end
  end

  def edit
    authorize @content
  end

  def destroy
    authorize @content
    @content.destroy
    redirect_to dashboard_doctor_path, notice: 'Content was successfully deleted.'
  end

  private

  def set_content
    @content = Content.find(params[:id])
  end

  def content_params
    params.require(:content).permit(:title, :text, :link_video, :content_type, :theme_type, :doctor_id, :files, :youtube_id, photos: [], attachments: [])
  end
end
