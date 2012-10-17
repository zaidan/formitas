module Formitas

  class Renderer
    # Abstract base class that renders a context
    class Context < self

      delegate :name

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
          fields.map(&:render).join('')
        end
        memoize :inner_html

        # Render form
        #
        # @return [String]
        #
        # @api private
        #
        def render
          content_tag(:form, inner_html, :action => action, :method => method, :enctype => enctype)
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
            Field.new(self, field)
          end
        end
        memoize :fields

        # Yield on error
        #
        # @yield 
        #   if form has error
        #
        # @return [self]
        #
        # @api private
        #
        def on_error
          yield if error?
          self
        end

        # Yield field renderer
        #
        # @yield [Field]
        #
        def field(name)
          yield Field.new(self, object.fields.get(name))
        end

        # Return field renderer
        #
        # @param [Symbol] name
        #
        # @return [Renderer::Field]
        #
        # @api private
        #
        def field_renderer(name)
          Field.new(self, object.fields.get(name))
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

        # Return input name
        #
        # @param [String] name
        #
        # @return [String]
        #
        # @api private
        #
        def input_name(name)
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
          object.violations.on(name)
        end
      end
    end
  end
end
