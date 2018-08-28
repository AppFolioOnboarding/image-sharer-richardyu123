class ImagesController < ApplicationController
  def index
    @images = Image.all.order('created_at DESC')
  end

  def new
    @image = Image.new
  end

  def create
    new_image = Image.new(new_image_params)
    if new_image.save

      redirect_to(image_path(new_image))
    else
      @image = Image.new
      render :new, locals: { errors: new_image.errors[:link][0] }, status: :unprocessable_entity
    end
  end

  def show
    if Image.exists?(params[:id])
      @image = Image.find(params[:id])
    else
      @image = Image.new
      render :new, locals: { errors: 'Page Not Found' }, status: :not_found
    end
  end

  def share
    @image = Image.find(params[:image_id])
  end

  private

  def new_image_params
    params[:image].permit(:link)
  end
end
