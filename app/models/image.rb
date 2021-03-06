class Image < ApplicationRecord
  validates :link, presence: true
  validates :link, url: true
  validates :tag_list, presence: true

  acts_as_taggable
end
