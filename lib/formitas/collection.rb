module Formitas
  # Abstract collection base class
  class Collection
    include Anima, AbstractClass, Enumerable, Adamantium

    # Attribute with default renderer lookup
    class DefaultLabelRenderer < Anima::Attribute
      DEFAULT = Anima::Default::Generator.new do |object|
        object.class.default_label_renderer
      end
    end

    def self.default_label_renderer
      self::DEFAULT_LABEL_RENDERER
    end

    attribute :label_renderer, DefaultLabelRenderer

    class String < self
      DEFAULT_LABEL_RENDERER = Renderer::Label::HTMLValue

      attribute :strings

      def each
        return to_enum unless block_given?

        strings.each do |string|
          yield Formitas::Option.new(:html_value => string, :domain_value => string)
        end
      end
    end

    class Hash < self
      DEFAULT_LABEL_RENDERER = Renderer::Label::HTMLValue

      attribute :hash
      def each
        return to_enum unless block_given?

        hash.each do |key,html_value|
          yield Option.new(key, html_value)
        end
      end
    end
  end
end
