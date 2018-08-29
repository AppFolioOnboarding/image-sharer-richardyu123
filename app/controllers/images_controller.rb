class ImagesController < ApplicationController
  def index
    tags = params[:tags]
    @images = if tags.present?
                Image.tagged_with(tags)
              else
                Image.all
              end
    @images = @images.order('created_at DESC')
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

  def destroy
    if Image.exists?(params[:id])
      image = Image.find(params[:id])
      image.destroy!
    end

    redirect_to(images_path)
  end

  private

  def new_image_params
    params[:image].permit(:link, :tag_list)
  end
end
