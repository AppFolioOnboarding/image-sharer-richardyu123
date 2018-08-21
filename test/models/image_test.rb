require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'link exists' do
    image = Image.new

    refute_predicate image, :valid?
  end

  test 'link is valid' do
    image = Image.new(link: 'http://www.google.com/')

    assert_predicate image, :valid?

    image = Image.new(link: 'invalid url')

    refute_predicate image, :valid?
  end
end
