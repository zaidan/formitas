module Formitas

  # Context of a named form element with fields
  class Context
    include Anima, Adamantium

    attribute :name
    attribute :fields
    attribute :values
    attribute :validator

    def value(name)
      values.get(name)
    end

    # Return if context is in a valid state
    #
    # @return [true]
    #   if valid
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    def valid?
      validator.valid?
    end

    # Return mutated context
    #
    # @api private
    #
    def update(attributes)
      self.class.new(self.attributes.merge(attributes))
    end

    # A form body without an action (nested form)
    class Body < self
    end

    # A form context with action (root form)
    class Form < self
      include Anima, Adamantium

      attribute :action
      attribute :method
      attribute :enctype

      # Return form renderer
      #
      # @return [Renderer::Form]
      #
      # @api private
      #
      def renderer
        Renderer::Context::Form.new(self)
      end
      memoize :renderer
    end
  end

end
