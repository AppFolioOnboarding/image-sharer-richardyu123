require_relative 'image_card'

module PageObjects
  module Images
    class IndexPage < AePageObjects::Document
      path :images

      element :flash_message, locator: '#flash_message'

      collection :images, locator: '.row', item_locator: '.card', contains: ImageCard do
        def view!
          node.find('img').click
          window.change_to(ShowPage)
        end
      end

      def share(id)
        node.find("#image_#{id}").click_on('Share')
        share_modal = element(locator: '#shareImage', is: ShareModal)
        share_modal.wait_until_visible
        yield(share_modal)
        share_modal.wait_until_hidden
      end

      def add_new_image!
        node.click_on('New')
        window.change_to(NewPage)
      end

      def showing_image?(link:, tags: nil)
        images.any? do |image|
          result = image.link == link
          tags.present? ? (result && image.tags == tags) : result
        end
      end

      def clear_tag_filter!
        node.click_on('Home')
        window.change_to(self.class)
      end
    end
  end
end
