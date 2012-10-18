module Formitas
  class Renderer
    class Field
      # Renderer for <select>
      class Select < self
        delegate :collection
        delegate :label_renderer

        def option_label(option)
          label_renderer.render(option)
        end

        def input_html
          HTML.content_tag(:select, options_html, :id => html_id, :name => html_name)
        end

        def selected?(domain_value)
          self.domain_value == domain_value
        end

        def options_html
          Collection::Options.render(collection, self)
        end
      end
    end
  end
end
