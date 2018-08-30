require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'link exists' do
    image = Image.new(tag_list: 'a')

    assert_not_predicate image, :valid?
  end

  test 'link is valid' do
    image = Image.new(link: 'http://www.google.com/', tag_list: 'a')

    assert_predicate image, :valid?

    image = Image.new(link: 'invalid url', tag_list: 'a')

    assert_not_predicate image, :valid?
  end

  test 'tag exists' do
    image = Image.new(link: 'https://www.image1.com/')

    assert_not_predicate image, :valid?
  end
end
