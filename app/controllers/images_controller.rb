class ImagesController < ApplicationController
  def new; end

  def create
    new_image = Image.new(new_image_params)
    new_image.save!
  end

  def show
    @image = Image.find(params[:id])
  end

  private

  def new_image_params
    params[:image].permit(:link)
  end
end
