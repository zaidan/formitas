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

    abstract_method :each

    attribute :label_renderer, DefaultLabelRenderer

    # Html value and domain value as string
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

    # Mapp html value to domain value
    class Mapper < self
      DEFAULT_LABEL_RENDERER = Renderer::Label::DomainValue

      attribute :mapping

      def each
        return to_enum unless block_given?

        mapping.each do |html_value, domain_value|
          yield Option.new(:html_value => html_value, :domain_value => domain_value)
        end

        self
      end
    end
  end
end
