require 'test_helper'

class ImageEmailsControllerTest < ActionDispatch::IntegrationTest
  test 'test sends correctly formatted email' do
    post image_emails_path, params: { image_email: { image_link: 'http://www.google.com/', address: 'a@ex.com' } }

    assert_response :found
    assert_redirected_to images_path

    get images_path
    assert_select '.alert.alert-success', 'Image email was successfully created.'
  end

  test 'test blank emails fail' do
    post image_emails_path, params: { image_email: { image_link: 'http://www.google.com/', address: '' } }

    assert_response :found
    assert_redirected_to images_path

    get images_path
    assert_select '.alert.alert-failure', 'Image email was not successfully created.'
  end

  test 'test invalid emails fail' do
    post image_emails_path, params: { image_email: { image_link: 'http://www.google.com/', address: 'abc' } }

    assert_response :found
    assert_redirected_to images_path

    get images_path
    assert_select '.alert.alert-failure', 'Image email was not successfully created.'
  end
end
