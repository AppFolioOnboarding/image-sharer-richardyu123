require_relative 'image_card'

module PageObjects
  module Images
    class IndexPage < AePageObjects::Document
      path :images

      collection :images, locator: '.row', item_locator: '.card', contains: ImageCard do
        def view!
          node.find('img').click
          window.change_to(ShowPage)
        end
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
