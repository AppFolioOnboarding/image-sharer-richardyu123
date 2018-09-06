require 'flow_test_helper'
class ImagesTest < FlowTestCase
  test 'add an image' do
    images_index_page = PageObjects::Images::IndexPage.visit
    new_image_page = images_index_page.add_new_image!
    tags = %w[foo bar]
    new_image_page = new_image_page.create_image!(
      link: 'invalid',
      tags: tags.join(', ')
    ).as_a(PageObjects::Images::NewPage)
    assert_equal 'Link is not a valid URL', new_image_page.link.error_message

    image_link = 'https://media3.giphy.com/media/EldfH1VJdbrwY/200.gif'
    new_image_page.image.link.set(image_link)
    image_show_page = new_image_page.create_image!
    assert_equal image_link, image_show_page.link
    assert_equal tags.join(' '), image_show_page.tags
    images_index_page = image_show_page.go_back_to_index!

    assert images_index_page.showing_image?(link: image_link, tags: tags.join(' '))
  end

  test 'delete an image' do
    cute_puppy_link = 'http://ghk.h-cdn.co/assets/16/09/980x490/landscape-1457107485-gettyimages-512366437.jpg'
    ugly_cat_link = 'http://www.ugly-cat.com/ugly-cats/uglycat041.jpg'
    Image.create!([
      { link: cute_puppy_link, tag_list: 'puppy, cute' },
      { link: ugly_cat_link, tag_list: 'cat, ugly' }
    ])
    images_index_page = PageObjects::Images::IndexPage.visit
    assert_equal 2, images_index_page.images.count
    assert images_index_page.showing_image?(link: ugly_cat_link)
    assert images_index_page.showing_image?(link: cute_puppy_link)
    image_to_delete = images_index_page.images.find do |image|
      image.link == ugly_cat_link
    end
    image_show_page = image_to_delete.view!
    image_show_page.delete do |confirm_dialog|
      assert_equal 'Are you sure?', confirm_dialog.text
      confirm_dialog.dismiss
    end
    images_index_page = image_show_page.delete_and_confirm!
    assert_equal 1, images_index_page.images.count
    assert_not images_index_page.showing_image?(link: ugly_cat_link)
    assert images_index_page.showing_image?(link: cute_puppy_link)
  end

  test 'view images associated with a tag' do
    puppy_link1 = 'http://www.pawderosa.com/images/puppies.jpg'
    puppy_link2 = 'http://ghk.h-cdn.co/assets/16/09/980x490/landscape-1457107485-gettyimages-512366437.jpg'
    cat_link = 'http://www.ugly-cat.com/ugly-cats/uglycat041.jpg'
    Image.create!([
      { link: puppy_link1, tag_list: 'superman, cute' },
      { link: puppy_link2, tag_list: 'cute, puppy' },
      { link: cat_link, tag_list: 'cat, ugly' }
    ])
    images_index_page = PageObjects::Images::IndexPage.visit
    [puppy_link1, puppy_link2, cat_link].each do |link|
      assert images_index_page.showing_image?(link: link)
    end
    images_index_page = images_index_page.images[1].click_tag!('cute')
    assert_equal 2, images_index_page.images.count
    assert_not images_index_page.showing_image?(link: cat_link)
    images_index_page = images_index_page.clear_tag_filter!
    assert_equal 3, images_index_page.images.count
  end

  test 'share an image' do
    puppy_link1 = 'http://www.pawderosa.com/images/puppies.jpg'
    puppy_link2 = 'http://ghk.h-cdn.co/assets/16/09/980x490/landscape-1457107485-gettyimages-512366437.jpg'
    cat_link = 'http://www.ugly-cat.com/ugly-cats/uglycat041.jpg'
    image1, _image2, _image3 = Image.create!([
      { link: puppy_link1, tag_list: 'superman, cute' },
      { link: puppy_link2, tag_list: 'cute, puppy' },
      { link: cat_link, tag_list: 'cat, ugly' }
    ])
    images_index_page = PageObjects::Images::IndexPage.visit
    [puppy_link1, puppy_link2, cat_link].each do |link|
      assert images_index_page.showing_image?(link: link)
    end
    images_index_page.share(image1.id) do |modal|
      modal.send_email(address: 'a@b.com')
    end

    assert_equal 'Image email was successfully created.', images_index_page.flash_message.text

    images_index_page.share(image1.id) do |modal|
      modal.send_email(address: 'a')
      assert_equal 'Address is invalid', modal.error.text
      modal.close
    end
  end
end
