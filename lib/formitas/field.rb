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
      self::RENDERER
    end

    def self.build(name, options = {})
      new(options.merge(:name => name))
    end

    # Abstract base class for <input> fields
    class Input < self
      # Abstract base class for <input type="text"> fields
      class Text < self
        RENDERER = Renderer::Field::Input::Text
      end

      # Class for <input type="checkbox> fields
      class Checkbox < self
        RENDERER = Renderer::Field::Input::Checkbox
      end
    end

    # Class for <select> fields
    class Select < self
      RENDERER = Renderer::Field::Select
      attribute :collection
    end

  end

end
