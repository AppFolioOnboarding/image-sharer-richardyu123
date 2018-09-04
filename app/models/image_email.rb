class ImageEmail
  include ActiveModel::Model

  attr_accessor :address, :message, :image_link

  validates :image_link, presence: true
  validates :address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
