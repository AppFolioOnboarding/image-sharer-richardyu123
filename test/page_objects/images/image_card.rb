module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      def link
        node.find('img')[:src]
      end

      def tags
        node.find('.js-tags').text
      end

      def click_tag!(tag_name)
        node.find(".js-tags a[href='/images?tags=#{tag_name}']").click
        window.change_to(IndexPage)
      end
    end
  end
end
