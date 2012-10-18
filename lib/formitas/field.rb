module Formitas

  # This hierarchy is stupid will replace it 
  # with task oriented inputs and configurable renderers soon.

  # Abstract base class for a form field 
  class Field
    include Anima, AbstractClass, Adamantium

    # Attribute with default renderer lookup
    class DefaultRenderer < Anima::Attribute
      DEFAULT = Anima::Default::Generator.new do |object|
        object.class.default_renderer
      end
    end

    attribute :name
    attribute :renderer, DefaultRenderer

    def self.default_renderer
      self::DEFAULT_RENDERER
    end

    def self.build(name, options = {})
      new(options.merge(:name => name))
    end

    # Abstract base class for <input> fields
    class String < self
      DEFAULT_RENDERER = Renderer::Field::Input::Text

      def html_value(object)
        object.to_s
      end
    end

    # Boolean field with true and false as domain values
    class Boolean < self
      DEFAULT_RENDERER = Renderer::Field::Input::Checkbox
    end

    # Select 
    class Select < self
      DEFAULT_RENDERER = Renderer::Field::Select

      attribute :collection
    end
  end
end
