#encoding: utf-8
module Formitas
  class Field
    class Input
      # Represent a HTML checkbox
      class CheckBox < self

        # Return input tag html
        # 
        # @return [String]
        #
        # @api private
        #
        def input_tag
          hidden_tag + tag(:input, html_attributes)
        end
        memoize :input_tag
        
      private

        # Return html attributes
        #
        # @return [Hash]
        #
        # @api private
        #
        def html_attributes
          super.merge(:checked => checked_value)
        end

        # Return checked value
        #
        # @return [Symbol]
        #   if input is checked
        #
        # @return [nil]
        #   otherwise
        #
        # @api private
        #
        def checked_value
          if checked?
            :checked
          end
        end

        # Test if input should be checked
        #
        # @return [true]
        #   if input should be checked
        #
        # @return [false]
        #   otherwise
        #
        # @api private
        #
        def checked?
          html_value == '1'
        end

        # Return hidden tag html
        #
        # @return [String]
        #
        # @api private
        #
        def hidden_tag
          tag(
            :input,
            :type => :hidden,
            :name => html_name,
            :value => '0'
          ) 
        end
      end
    end
  end
end
