class ImagesController < ApplicationController
  def new; end

  def create
    new_image = Image.new(new_image_params)
    if new_image.valid?
      new_image.save!

      redirect_to(image_path(new_image))
    else
      render :new, locals: { errors: new_image.errors[:link] }, status: :unprocessable_entity
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  private

  def new_image_params
    params[:image].permit(:link)
  end
end
