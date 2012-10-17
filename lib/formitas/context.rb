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

    def error?
      !validator.valid?
    end

    def violations
      validator.violations
    end

    def update(attributes)
      self.class.new(self.attributes.merge(attributes))
    end

    # A form body without an action (subform)
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
