class ImagesController < ApplicationController
  def new; end

  def create
    new_image = Image.new(new_image_params)
    new_image.save!
  end

  private

  def new_image_params
    params[:image].permit(:link)
  end
end
