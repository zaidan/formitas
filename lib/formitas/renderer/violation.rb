module Formitas
  class Renderer
    # Renderer for (aequitas) violations
    class Violation < self

      attr_reader :field
      private :field

      delegate :type

      # Return field name
      #
      # @return [Symbol]
      #
      # @api private
      #
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
        HTML.li(message, :class => 'error-message')
      end
      memoize :render

      # Return dumb violation message
      #
      # @return [String]
      #
      # @api private
      #
      def dumb_violation_message
        "#{human_attribute_name}: #{Inflector.humanize(type)}".freeze
      end

      # Return message
      #
      # @return [String]
      #
      # @api private
      #
      def message
        human_attribute_name = self.human_attribute_name

        string = Formitas.translate(
          lookups, 
          :attribute => human_attribute_name
        )

        string.equal?(Undefined) ? dumb_violation_message : string
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
        type = self.type
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

