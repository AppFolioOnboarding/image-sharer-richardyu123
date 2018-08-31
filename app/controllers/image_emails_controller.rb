class ImageEmailsController < ApplicationController
  before_action :set_image_email, only: [:show, :edit, :update, :destroy]

  # GET /image_emails
  def index
    @image_emails = ImageEmail.all
  end

  # GET /image_emails/1
  def show
  end

  # GET /image_emails/new
  def new
    @image_email = ImageEmail.new
  end

  # GET /image_emails/1/edit
  def edit
  end

  # POST /image_emails
  def create
    @image_email = ImageEmail.new(image_email_params)

    if @image_email.save
      ImageEmailMailer.send_email(@image_email, request.base_url + images_path).deliver
      flash[:success] = 'Image email was successfully created.'
      redirect_to images_path
    else
      flash[:failure] = 'Image email was not successfully created'
      redirect_to images_path
    end
  end

  # PATCH/PUT /image_emails/1
  def update
    if @image_email.update(image_email_params)
      redirect_to @image_email, notice: 'Image email was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /image_emails/1
  def destroy
    @image_email.destroy
    redirect_to image_emails_url, notice: 'Image email was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_image_email
    @image_email = ImageEmail.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def image_email_params
    params.require(:image_email).permit(:message, :image_link, :address)
  end
end
