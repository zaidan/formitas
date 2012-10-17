module Formitas

  # Abstract class for a form field without 
  class Field
    include Anima, AbstractClass, Adamantium

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

    class Input < self
      class Text < self
        RENDERER = Renderer::Field::Input::Text
      end
    end

    class Select < self
      RENDERER = Renderer::Field::Select
      attribute :collection
    end

    class Checkbox < self
      RENDERER = Renderer::Field::Input::Checkbox
    end
  end

end
