module Formitas
  class Renderer
    class Violation < self

      attr_reader :field
      private :field

      delegate :type

      def field_name
        field.name
      end

      # Return human attribute name
      #
      # @api private
      #
      def human_attribute_name
        field.label_text
      end

      # Return violation html
      #
      # @return [String]
      #
      # @api private
      #
      def render
        content_tag(:span, message, :class => 'error-message')
      end
      memoize :render

      # Return message
      #
      # @return [String]
      #
      # @api private
      #
      def message
        string = Formitas.translate(
          lookups, 
          :attribute => human_attribute_name
        )

        if string.equal?(Undefined) 
          "#{human_attribute_name}: #{Inflector.humanize(type)}"
        else
          string
        end
      end
      memoize :message


    private

      # Return lookups
      #
      # @return [Enumerable<Object>]
      #
      # @api private
      #
      def lookups
        [
          [field.context_name, field_name, type].join('.'),
          [:aequitas, type].join('.')
        ]
      end

      # Initialize object
      #
      # @param [Violation] object
      # @param [Renderer::Field] field
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(object, field)
        @field = field
        super(object)
      end
    end
  end
end

