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
    assert_select '.invalid-feedback', %(Link can't be blank and Link is not a valid URL)
  end

  test 'test create failure on invalid url' do
    assert_no_difference 'Image.count' do
      post images_path, params: { image: { link: 'a' } }
    end

    assert_response :unprocessable_entity
    assert_select '.invalid-feedback', %(Link is not a valid URL)
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
    assert_select 'div[class="card"]'
    assert_select 'img[src="https://www.google.com/"]'
    assert_select 'a, b, c, d'
  end

  test 'test multiple tags separated by comma' do
    image = Image.create!(link: 'https://www.google.com/')
    image.tags.create(name: 'tag1')
    image.tags.create(name: 'tag2')
    image.save!

    get images_path

    assert_response :ok
    assert_select 'p a:nth-child(1)', text: 'tag1'
    assert_select 'p a:nth-child(2)', text: 'tag2'
  end

  test 'test form to fill tags' do
    get new_image_path

    assert_response :ok
    assert_select 'div[class="form-group string optional image_tag_list"]'
  end

  test 'test images with a certain tag show' do
    Image.create!(link: 'https://www.image1.com/', tag_list: 'a, b, c')
    Image.create!(link: 'https://www.image2.com/', tag_list: 'a, b')

    get images_path(tags: 'a')

    assert_response :ok
    assert_select 'img[src="https://www.image1.com/"]'
    assert_select 'img[src="https://www.image2.com/"]'
  end

  test 'test images without a certain tag do not show' do
    Image.create!(link: 'https://www.image1.com/', tag_list: 'a, b, c')
    Image.create!(link: 'https://www.image2.com/', tag_list: 'a, b')

    get images_path(tags: 'c')

    assert_response :ok
    assert_select 'img[src="https://www.image1.com/"]'
    assert_select 'img[src="https://www.image2.com/"]', false
  end

  test 'test no images for unused tag' do
    Image.create!(link: 'https://www.image1.com/', tag_list: 'a, b, c')
    Image.create!(link: 'https://www.image2.com/', tag_list: 'a, b')

    get images_path(tags: 'd')

    assert_response :ok
    assert_select 'img', false
  end

  test 'test destroy' do
    image = Image.create!(link: 'https://www.image1.com/', tag_list: 'a, b, c')
    assert_difference 'Image.count', -1 do
      delete image_path(image)
    end

    assert_redirected_to images_path
  end

  test 'test delete button shows' do
    image = Image.create!(link: 'https://www.image1.com/', tag_list: 'a, b, c')
    get image_path(image)

    assert_response :ok
    assert_select '.btn.btn-danger'
  end
end
