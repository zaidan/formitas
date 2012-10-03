#encoding: utf-8
module Formitas
  class Dumper
    # Method object for rendering HTML error content 
    class Error < self
      include WebHelpers, Immutable
      
      # Return dump
      #
      # @return [Hash]
      #   the dumped representation
      #
      # @api private
      #
      def dump 
        content_tag(
          :p,
          escape_html(error),
          attributes
        )
      end

    private

      # Initialize dumper
      # 
      # @param [Enumerable] errors
      # @param [String] base_id
      # 
      # @return [undefined]
      #
      # @api private
      #
      def initialize(error, base_id)
        @object, @base_id = error, base_id
      end

      # Return errors
      # 
      # @return [Enumerable]
      #
      # @api private
      #
      def error
        object
      end
      memoize :error

      # Return base id
      # 
      # @return [String]
      #
      # @api private
      #
      def base_id
        @base_id
      end
      memoize :base_id
      
      # Return attributes for content tag
      # 
      # @return [Hash]
      #
      # @api private
      #
      def attributes
        {
          :class => css_class,
          :id => id 
        }
      end
      memoize :attributes

      # Return css error class
      #
      # @return [String]
      # 
      # @api private  
      #
      def css_class
        :error
      end
      memoize :css_class

      # Return error id
      #
      # @return [String]
      # 
      # @api private  
      #
      def id
        "#{base_id}_error_msg_#{name}"
      end
      memoize :id

      # Return error name
      #
      # @return [String]
      # 
      # @api private  
      #
      def name
        rule.violation_type
      end
      memoize :name

      # Return Aequitas rule
      #
      # @return [Rule]
      # 
      # @api private  
      #
      def rule
        error.rule
      end
      memoize :rule
    end
  end
end
