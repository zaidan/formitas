#encoding: utf-8
module Formitas
  class Field
    # Represent a HTML input field
    class Input < self

      TYPE = :text

      # Return html text input tag
      #
      # @return [String]
      #
      # @api private
      #
      def input_tag
        tag(:input, attributes)
      end
      memoize :input_tag

    private

      # Return html attributes
      #
      # @return [Hash]
      #
      # @api private
      #
      def html_attributes
        super.merge(:type => type, :value => html_value)
      end

      # Return type attribute value
      # 
      # @return [Symbol]
      #
      # @api private
      #
      def type
        self.class::TYPE
      end
    end
  end
end
