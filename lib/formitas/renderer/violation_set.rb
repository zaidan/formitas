module Formitas
  class Renderer
    # Renderer for a set of violations
    class ViolationSet < self

      attr_reader :field

      def initialize(object, field)
        super(object)
        @field = field
      end

      def empty?
        !violations.empty?
      end

      def violations
        object.map do |violation|
          Violation.new(violation, field)
        end
      end
      memoize :violations

      def render
        if violations.empty?
          ''
        else
          HTML.content_tag(:div, inner_html, :class => :'error-messages')
        end
      end
      memoize :render

      def list_items_html
        contents = violations.map { |violation| violation.render }
        HTML.join(contents)
      end

      def inner_html
        HTML.content_tag(:ul, list_items_html)
      end
      memoize :inner_html
    end
  end
end
