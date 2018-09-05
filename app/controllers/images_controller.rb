class ImagesController < ApplicationController
  def edit
    @image = Image.find(params[:id])
    @image_email = ImageEmail.new
  end

  def update
    @image = Image.find(params[:id])
    if @image.update(update_image_params)
      redirect_to image_path(@image)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    tags = params[:tags]
    @images = if tags.present?
                Image.tagged_with(tags)
              else
                Image.all
              end
    @images = @images.order('created_at DESC')
    @image_email = ImageEmail.new
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(new_image_params)
    if @image.save

      redirect_to(image_path(@image))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    if Image.exists?(params[:id])
      @image = Image.find(params[:id])
      @image_email = ImageEmail.new
    else
      @image = Image.new
      render :new, status: :not_found
    end
  end

  def share
    @image = Image.find(params[:image_id])
    @image_email = ImageEmail.new
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

  def update_image_params
    params[:image].permit(:tag_list)
  end
end
