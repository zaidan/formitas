#encoding: utf-8
module Formitas
  class Field
    # Represent a HTML textarea
    class Textarea < Field

      # Return input html
      #
      # @return [String]
      #
      # @api private
      #
      def input_tag
        content_tag(
          :textarea,
          escape_html(html_value),
          html_attributes
        )
      end
      memoize :input_tag
    end
  end
end
