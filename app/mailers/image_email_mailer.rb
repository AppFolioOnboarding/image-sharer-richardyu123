class ImageEmailMailer < ApplicationMailer
  def send_email(image_email, url)
    @email = image_email
    @url = url
    mail(to: @email.address, subject: 'You have been sent an image!')
  end
end
