module Formitas

  class Renderer
    class Context

      # Render a full form
      class Form < self

        # Return html id
        #
        # @return [String]
        #
        # @api private
        #
        def html_id
          name.to_s
        end
        memoize :html_id

        delegate :error?, :method, :action, :enctype

        # Return inner_html
        #
        # @return [String]
        #
        # @api private
        #
        def inner_html
          HTML.join(fields.map { |field| field.render })
        end
        memoize :inner_html

        # Render form
        #
        # @return [String]
        #
        # @api private
        #
        def render
          HTML.content_tag(:form, inner_html, :action => action, :method => method, :enctype => enctype)
        end
        memoize :render

        # Return field renderers
        #
        # @return [Enumerable<Renderer:Field>]
        #
        # @api private
        #
        def fields
          object.fields.map do |field|
            Field.build(field, self)
          end
        end
        memoize :fields

        # Return field renderer
        #
        # @param [Symbol] name
        #
        # @return [Renderer::Field]
        #
        # @api private
        #
        def field_renderer(name)
          Field.build(self, object.fields.get(name))
        end

        # Render field
        #
        # @param [Symbol] name
        #
        # @return [String]
        #
        # @api private
        #
        def render_field(name)
          field_renderer(name).render
        end

        # Return html name
        #
        # @param [String] name
        #
        # @return [String]
        #
        # @api private
        #
        def html_name(name)
          "#{self.name}[#{name}]"
        end

        # Return violations
        #
        # @param [String] name
        #
        # @return [Enumerable<Violation>]
        #
        # @api private
        #
        def violations(name)
          object.validator.violations.on(name)
        end
      end
    end
  end
end
