require 'test_helper'

class ImageEmailTest < ActiveSupport::TestCase
  test 'image_link exists' do
    image_email = ImageEmail.new(address: 'a@ex.com')

    assert_not_predicate image_email, :valid?
  end
  test 'address exists' do
    image_email = ImageEmail.new(image_link: 'http://www.google.com/')

    assert_not_predicate image_email, :valid?
  end
  test 'address is valid' do
    image_email = ImageEmail.new(address: 'abc', image_link: 'http://www.google.com/')

    assert_not_predicate image_email, :valid?
  end
end
