class Image < ApplicationRecord
  validates :link, presence: true
  validates :link, url: true
end
