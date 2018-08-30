module PageObjects
  module Images
    class ShowPage < AePageObjects::Document
      path :image

      def link
        node.find('img')[:src]
      end

      def tags
        node.find('.js-tags').text
      end

      def delete
        node.click_on('Delete')
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        node.click_on('Delete')
        node.driver.browser.switch_to.alert.accept
        window.change_to(IndexPage)
      end

      def go_back_to_index!
        node.click_on('Home')
        window.change_to(IndexPage)
      end
    end
  end
end
