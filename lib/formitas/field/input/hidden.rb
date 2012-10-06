#encoding: utf-8
module Formitas
  class Field
    class Input
      # Represent a HTML hidden field
      class Hidden < self

        TYPE = :hidden

    private
        
        # Hidden fields have no labels
        #
        # @return [nil]
        #   allways 
        # 
        # @api private  
        #
        def label_tag; end
      end
    end
  end
end
