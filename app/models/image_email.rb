class ImageEmail < ApplicationRecord
  validates :image_link, presence: true
  validates :address, presence: true
end
