require 'test_helper'

class ImageEmailsControllerTest < ActionDispatch::IntegrationTest
  test 'test sends correctly formatted email' do
    post image_emails_path, params: { image_email: { image_link: 'http://www.google.com/', address: 'a@ex.com' } }

    assert_response :ok

    json_response = JSON.parse(response.body)
    assert_includes json_response['flash'], 'Image email was successfully created.'
  end

  test 'test blank emails fail' do
    post image_emails_path, params: { image_email: { image_link: 'http://www.google.com/', address: '' } }

    assert_response :unprocessable_entity

    json_response = JSON.parse(response.body)
    assert_includes json_response['error_modal'],'Address can&#39;t be blank and Address is invalid'
  end

  test 'test invalid emails fail' do
    post image_emails_path, params: { image_email: { image_link: 'http://www.google.com/', address: 'abc' } }

    assert_response :unprocessable_entity

    json_response = JSON.parse(response.body)
    assert_includes json_response['error_modal'],'Address is invalid'
  end
end
