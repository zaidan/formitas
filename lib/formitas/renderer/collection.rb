module Formitas
  class Renderer
    # Abstract class for rendering a collection
    class Collection < self
      include AbstractClass, Adamantium

      delegate :label_renderer

      def option_label(option)
        label_renderer.render(option)
      end

      # Render a collection with <option> tags
      class Options < self
        def render
          HTML.join(options_html)
        end

        def selected?(domain_value)
          context.selected?(domain_value)
        end

        def options_html
          object.map do |option|
            Renderer::Option.render(option, self)
          end
        end
      end
    end
  end
end
