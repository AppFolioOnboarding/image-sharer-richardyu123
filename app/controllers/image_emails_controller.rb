class ImageEmailsController < ApplicationController
  def create
    @image_email = ImageEmail.new(image_email_params)

    if @image_email.valid?
      ImageEmailMailer.send_email(@image_email, request.base_url + images_path).deliver
      flash.now[:success] = 'Image email was successfully created.'
      render json: { flash: render_to_string(partial: 'layouts/flash', format: :html) }, status: :ok
    else
      render json: { error_modal: render_to_string(partial: 'images/share_form_modal', locals: { image_email: @image_email }, format: :html) }, status: :unprocessable_entity
    end

  end

  private

  # Only allow a trusted parameter "white list" through.
  def image_email_params
    params.require(:image_email).permit(:message, :image_link, :address)
  end
end
