require 'test_helper'

class ImageEmailMailerTest < ActionMailer::TestCase
  test 'send_mail' do
    image_email = ImageEmail.new(address: 'me@example.com', image_link: 'http://www.image1.com/')
    # Create the email and store it for further assertions
    email = ImageEmailMailer.send_email(image_email, 'friend@example.com')

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ['from@example.com'], email.from
    assert_equal ['me@example.com'], email.to
    assert_equal 'You have been sent an image!', email.subject
    doc = Nokogiri::HTML::Document.parse(email.html_part.body.to_s)
    assert_select doc, 'h1', 'You have been sent an image!'
    assert_select doc, 'img[src=?]', 'http://www.image1.com/'
  end
end
