require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'test_new' do
    get new_image_path

    assert_response :ok
    assert_select 'form'
  end

  test 'test create' do
    assert_difference 'Image.count' do
      post images_path, params: { image: { link: 'http://www.google.com/' } }
    end

    assert_redirected_to image_path(Image.last)
    assert_equal 'http://www.google.com/', Image.last.link
  end

  test 'test create failure on blank' do
    assert_no_difference 'Image.count' do
      post images_path, params: { image: { link: '' } }
    end

    assert_response :unprocessable_entity
    assert_select '.js-errors', %(can't be blank)
  end

  test 'test create failure on invalid url' do
    assert_no_difference 'Image.count' do
      post images_path, params: { image: { link: 'a' } }
    end

    assert_response :unprocessable_entity
    assert_select '.js-errors', %(is not a valid URL)
  end

  test 'test invalid address' do
    get image_path('123123')

    assert_response :not_found
    assert_select 'form'
  end

  test 'test show' do
    image = Image.create!(link: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Bucephala-albeola-010.jpg/1200px-Bucephala-albeola-010.jpg')

    get image_path(image)

    assert_response :ok
    assert_select 'img'
  end

  test 'test image index' do
    get images_path

    assert_response :ok
    assert_select 'img', 0
  end

  test 'test index with image' do
    Image.create!(link: 'http://www.google.com/')
    get images_path

    assert_response :ok
    assert_select 'img'
  end

  test 'test adding tags' do
    Image.create!(link: 'https://www.google.com/', tag_list: 'a, b, c, d')
    get new_image_path

    assert_response :ok
  end

  test 'test tags show on index' do
    Image.create!(link: 'https://www.google.com/', tag_list: 'a, b, c, d')
    get images_path

    assert_response :ok
    assert_select 'a, b, c, d'
  end
end
