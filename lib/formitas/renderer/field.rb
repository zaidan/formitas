module Formitas
  class Renderer

    class Field < self
      attr_reader :context

      delegate :name

      def initialize(context, object)
        @context = context
        super(object)
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

      def render
        content_tag(:div, inner_html, :class => :input)
      end

      def html_id
        "#{context.html_id}_#{name}"
      end
      memoize :html_id

      def input_name
        context.input_name(name)
      end
      memoize :input_name

      def label_html
        content_tag(:label, label_text, :for => html_id)
      end
      memoize :label_html

      def input_html
        tag(:input, :id => html_id, :type => :text, :name => input_name, :value => '')
      end
      memoize :input_html

      def errors_html
        violations.render
      end
      memoize :errors_html

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
  end
end
