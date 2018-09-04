class ImageEmailsController < ApplicationController
  def create
    @image_email = ImageEmail.new(image_email_params)

    if @image_email.save
      ImageEmailMailer.send_email(@image_email, request.base_url + images_path).deliver
      flash[:success] = 'Image email was successfully created.'
    else
      flash[:failure] = 'Image email was not successfully created.'
    end

    redirect_to images_path
  end

  private

  # Only allow a trusted parameter "white list" through.
  def image_email_params
    params.require(:image_email).permit(:message, :image_link, :address)
  end
end
