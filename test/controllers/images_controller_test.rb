require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'test_new' do
    get new_image_path

    assert_response :ok
    assert_select 'form'
  end
end
