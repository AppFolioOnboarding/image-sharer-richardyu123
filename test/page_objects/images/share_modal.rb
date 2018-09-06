module PageObjects
  module Images
    class ShareModal < AePageObjects::Element
      form_for :image_email do
        element :address
        element :message
      end

      element :error, locator: '.invalid-feedback'

      def send_email(address: nil, message: nil)
        self.message.set(message) if message.present?
        self.address.set(address) if address.present?

        node.click_on('Send')
      end

      def close
        node.click_on('Close')
      end
    end
  end
end
