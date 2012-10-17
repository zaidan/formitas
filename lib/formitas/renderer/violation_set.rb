module Formitas
  class Renderer
    # Renderer for a set of violations
    class ViolationSet < self

      attr_reader :field

      def initialize(object, field)
        super(object)
        @field = field
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
          content_tag(:div, inner_html, :class => :error_set)
        end
      end
      memoize :render

      def inner_html
        list_items = []
        violations.each do |violation|
          content_tag(:li, violation.render)
        end
        content_tag(:ul, list_items.join(''))
      end
      memoize :inner_html
    end
  end
end
