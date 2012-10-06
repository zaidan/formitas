#encoding: utf-8
module Formitas
  class Field
    # Represent a HTML select field
    class Select < self

      attribute :options

      # Return html input
      #
      # @return [String]
      #
      # @api private
      #
      def input_tag
        content_tag(:select, option_html, html_attributes)
      end
      memoize :input_tag

    private
    
      # Return option html
      #
      # @return [String]
      #
      # @api private
      #
      def option_html
        options.map(&:html).join('')
      end

    end
  end
end
