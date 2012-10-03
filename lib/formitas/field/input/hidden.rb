#encoding: utf-8
module Formitas
  class Field
    class Input
      # Represent a HTML hidden field
      class Hidden < self

    private
      
        def type
          :hidden
        end
        
        # Hidden fields have no labels
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
