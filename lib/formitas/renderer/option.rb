module Formitas
  class Renderer
    # Renderer for select <option>
    class Option < self

      delegate :label, :html_value, :domain_value

      def selected?
        @context.selected?(domain_value)
      end
      memoize :selected?

      def render
        attributes = { :value => html_value }
        attributes[:selected] = :selected if selected?
        HTML.option(@context.option_label(self), attributes)
      end
      memoize :render

    end
  end
end
