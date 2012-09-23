#encoding: utf-8
module Formitas
  class Field
    class Input
      class Submit < self
        
      private
        
        def type
          :submit
        end

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
        #   returns allways nil
        # 
        # @api private  
        #
        def error_tag
        end
        
        # Submit fields have no labels
        #
        # @return [nil]
        #   returns allways nil
        # 
        # @api private  
        #
        def label_tag
        end
      end
    end
  end
end
