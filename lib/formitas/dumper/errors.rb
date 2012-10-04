#encoding: utf-8
module Formitas
  class Dumper
    # Method object for rendering HTML error content 
    class Errors < self
      include WebHelpers, Immutable
      
      # Return dump
      #
      # @return [Hash]
      #   the dumped representation
      #
      # @api private
      #
      def dump 
        error_tag if errors?
      end
      memoize :dump

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
      def initialize(errors, base_id)
        @errors, @base_id = errors, base_id
      end

      # Return errors
      # 
      # @return [Enumerable]
      #
      # @api private
      #
      attr_reader :errors

      # Return base id
      # 
      # @return [String]
      #
      # @api private
      #
      attr_reader :base_id

      # Test if errors exist
      #
      # @return [true]
      #   if errors exist
      # 
      # @return [false]
      #   false otherwise
      # 
      # @api private  
      #
      def errors?
        !errors.empty?
      end
      memoize :errors?

      # Return errors as HTML code
      #
      # @return [String]
      #   errors as HTML content tag
      #
      # @api private  
      #
      def error_tag
        content_tag(
          :div,
          error_contents, 
          attributes
        )
      end
      memoize :error_tag

      # Return attributes for content tag
      # 
      # @return [Hash]
      #
      # @api private
      #
      def attributes
        {
          :class => :error, 
          :id => "#{base_id}_error"
        }
      end
      memoize :attributes

      # Return error contents
      #
      # @return [String]
      #   error content
      # 
      # @api private  
      #
      def error_contents
        Error.dump_items(errors, base_id).join('')
      end
      memoize :error_contents
    end
  end
end
