class ContentsController < ApplicationController

  def index
    @contents = Content.all
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    @content.doctor = current_doctor
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
    @content.update(content_params)
    redirect_to content_path(@content)
  end

  def edit
    @content = Content.find(params[:id])
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    redirect_to dashboard_doctor_path, notice: 'Content was successfully deleted.'
  end

  private

  def content_params
    params.require(:content).permit(:title, :text, :link_video, :content_type, :theme_type, :doctor_id, :files, photos: [])
  end
end
