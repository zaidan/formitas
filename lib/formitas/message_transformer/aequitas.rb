module Formitas
  class MessageTransformer
    # Message transformer in the aequitas namespace
    class Aequitas < self
    
      # Return base scope
      #
      # @return [Array<String>]
      #
      # @api private
      #
      def base_scope
        [:aequitas]
      end

      # Return translation key
      #
      # @return [Symbol]
      #
      # @api private
      #
      def key
        :label
      end
    
      # Options for translation scope
      #
      # @return [Hash]
      #
      # @api private
      #
      def options
        {
          :attribute => attribute,
          :scope     => scope
        }
      end
      memoize :options
    end
  end
end
