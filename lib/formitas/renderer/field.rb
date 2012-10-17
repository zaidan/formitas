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
        [
          label_html,
          input_html,
          errors_html
        ].join('')
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
        content_tag(:div, inner_html, :class => css_classes)
      end
      memoize :render

      # Return label html
      #
      # @return [String]
      #
      # @api private
      #
      def label_html
        content_tag(:label, label_text, :for => html_id)
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
      def input_name
        context.input_name(name)
      end
      memoize :input_name


      abstract_method :input_html

      # Return errors html
      #
      # @api private
      #
      def errors_html
        violations.render
      end
      memoize :errors_html

      # Return raw value if any
      #
      # @return [Object]
      #   if value is present
      #
      # @return [Formitas::Undefined]
      #   otherwise
      #
      # @api private
      #
      def value
        context.value(name)
      end
      memoize :value

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

    private

      # Initialize object
      #
      # @param [Field] object
      # @param [Context] context
      # 
      # @api private
      #
      def initialize(object, context)
        super(object)
        @context = context
      end
    end

    class Field

      # Renderer for <select>
      class Select < self
        delegate :collection

        def input_html
          content_tag(:select, options_html, :id => html_id, :name => input_name)
        end

        def options_html
          collection.map do |name|
            option_html(name)
          end.join('')
        end

      private

        def option_html(name)
          attributes = { :value => name }
          attributes[:selected] = :selected if name == value
          content_tag(:option, escape_html(name), attributes)
        end
      end

      # Renderer for <input type="checkbox">
      class Checkbox < self
      end

      # Abstract class for <input> tag fields
      class Input < self

        def input_value
          value = self.value
          value_or_undefined = value
          value_or_undefined.equal?(Undefined) ? '' : value
        end
        memoize :input_value

        def type
          self.class::TYPE
        end

        def input_html
          tag(:input, :id => html_id, :type => type, :name => input_name, :value => input_value)
        end
        memoize :input_html

        class Text < self
          TYPE = :text
        end
      end
    end
  end
end
