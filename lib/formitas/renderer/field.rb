module Formitas
  class Renderer

    # Abstract class for field renderers
    class Field < self
      include AbstractClass

      # Build field renderer
      #
      # @param [Field] field
      # @param [Context] context
      #
      # @return [Renderer]
      #
      # @api private
      #
      def self.build(field, context)
        field.renderer.new(field, context)
      end

      # Return rendering context
      #
      # @return [Renderer::Context]
      #
      # @api private
      #
      attr_reader :context

      # Return name of field
      #
      # @return [Symbol]
      #
      # @api private
      #
      delegate :name

      # Return context namee
      #
      # @return [Symbol]
      #
      # @api private
      #
      def context_name
        context.name
      end

      # Return label text
      #
      # @return [String]
      #
      # @api private
      #
      def label_text
        name = self.name
        I18n.translate(name, :scope => [context_name, :label], :default => Inflector.humanize(name))
      end
      memoize :label_text

      # Return inner html
      #
      # @return [String]
      #
      # @api private
      #
      def inner_html
        HTML.join([
          label_html,
          input_html,
          errors_html
        ])
      end

      # Return css classes
      #
      # @return [String]
      #
      # @api private
      #
      def css_classes
        css = 'input'
        css += ' error' unless valid?
        css
      end
      memoize :css_classes

      # Return rendered html
      #
      # @return [String]
      #
      # @api private
      #
      def render
        HTML.div(inner_html, :class => css_classes)
      end
      memoize :render

      # Return label html
      #
      # @return [String]
      #
      # @api private
      #
      def label_html
        HTML.label(label_text, :for => html_id)
      end
      memoize :label_html

      # Return unique html id 
      #
      # @return [String]
      #
      # @api private
      #
      def html_id
        "#{context.html_id}_#{name}"
      end
      memoize :html_id

      # Return input name
      #
      # @return [String]
      # 
      # @api private
      #
      def html_name
        context.html_name(name)
      end
      memoize :html_name


      abstract_method :input_html

      # Return errors html
      #
      # @api private
      #
      def errors_html
        violations.render
      end
      memoize :errors_html

      # Return html input value if any
      #
      # @return [String]
      #   if value is present
      #
      # @return [Formitas::Undefined]
      #   otherwise
      #
      # @api private
      #
      def html_value
        context.html_value(name)
      end
      memoize :html_value

      # Return domain value if any
      #
      # @return [Object]
      #   if value is present
      #
      # @api private
      #
      def domain_value
        context.domain_value(name)
      end
      memoize :domain_value

      # Test if input is valid for field
      #
      # @return [true]
      #   if valid
      #
      # @return [false]
      #   otherwise
      #
      # @api private
      #
      def valid?
        field_violations.empty?
      end

      # Return field violations
      #
      # @return [Enumerable<Violation>]
      #
      # @api private
      #
      def field_violations
        context.violations(name)
      end
      memoize :field_violations

      # Return violations renderer
      #
      # @return [Renderer::Violations]
      #
      # @api private
      #
      def violations
        ViolationSet.new(field_violations, self)
      end
      memoize :violations

    end
  end
end
