class Image < ApplicationRecord
  validates :link, presence: true
  validates :link, url: true

  acts_as_taggable
end
