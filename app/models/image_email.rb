class ImageEmail < ApplicationRecord
  validates :image_link, presence: true
  validates :address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
