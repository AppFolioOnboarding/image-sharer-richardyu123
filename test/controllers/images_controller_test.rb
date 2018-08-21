require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'test_new' do
    get new_image_path

    assert_response :ok
    assert_select 'form'
  end

  test 'test create' do
    assert_difference 'Image.count' do
      post images_path, params: { image: { link: 'http://www.google.com/' }}
    end

    assert_response :no_content
    assert_equal 'http://www.google.com/', Image.last.link
  end

  test 'test show' do
    image = Image.create!(link: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Bucephala-albeola-010.jpg/1200px-Bucephala-albeola-010.jpg')

    get image_path(image)

    assert_response :ok
    assert_select 'img'
  end
end
