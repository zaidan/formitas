module Formitas
  class Renderer

    # Abstract class for field renderers
    class Field < self
      include AbstractClass

      def self.build(field, context)
        field.renderer.new(field, context)
      end

      attr_reader :context
      delegate :name

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

      # Return context namee
      #
      # @return [Symbol]
      #
      # @api private
      #
      def context_name
        context.name
      end

      # Return label scope
      #
      # @return [Array]
      #
      # @api private
      #
      def label_scope
        [context_name, :label]
      end
      memoize :label_scope

      # Return label text
      #
      # @return [String]
      #
      # @api private
      #
      def label_text
        I18n.translate(name, :scope => label_scope, :default => Inflector.humanize(name))
      end
      memoize :label_text

      def inner_html
        [
          label_html,
          input_html,
          errors_html
        ].join('')
      end

      def css_classes
        classes = %w(input)
        classes << 'error' unless errors_html.empty?
        classes.join(' ')
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

      abstract_method :input_html

      # Return errors html
      #
      # @api private
      #
      def errors_html
        violations.render
      end
      memoize :errors_html

      def value
        context.value(name)
      end

      def error?
        !violations.empty?
      end

      # Return violations renderer
      #
      # @return [Renderer::Violations]
      #
      # @api private
      #
      def violations
        ViolationSet.new(context.violations(name), self)
      end
      memoize :violations
    end

    class Field

      class Select < self
        delegate :collection

        def input_html
          content_tag(:select, options_html, :id => html_id, :name => input_name)
        end

        def options_html
          collection.map do |name|
            attributes = { :value => name }
            attributes[:selected] = :selected if name == value
            content_tag(:option, escape_html(name), attributes)
          end.join('')
        end
      end

      class Checkbox < self
      end

      # Abstract class for <input> tag fields
      class Input < self

        def input_value
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
