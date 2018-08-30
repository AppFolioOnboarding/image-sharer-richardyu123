module PageObjects
  module Extensions
    module ElementInlineErrorMessage
      def error_message
        parent = find_parent
        Capybara.using_wait_time(0) do
          parent.find('.invalid-feedback').text
        rescue Capybara::ElementNotFound
          ''
        end
      end

      private

      def find_parent
        node.find(:xpath, "ancestor::*[contains(concat(' ',normalize-space(@class), ' '),' form-group ')][1]") ||
          node.parent
      end
    end
  end
end
