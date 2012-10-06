#encoding: utf-8
module Formitas
  class Field
    class Input
      # Represent a HTML submit field
      class Submit < self

        TYPE = :submit
        
      private

        # Return translated HTML value
        #
        # @return [String]
        #   returns translated HTML value
        # 
        # @api private  
        #
        def html_value
          I18n.translate("#{basename}.new.#{name}")
        end
        
        # Submit fields have no errors
        #
        # @return [nil]
        #   allways nil
        # 
        # @api private  
        #
        def error_tag; end
        
        # Submit fields have no labels
        #
        # @return [nil]
        #   allways nil
        # 
        # @api private  
        #
        def label_tag; end
      end
    end
  end
end
