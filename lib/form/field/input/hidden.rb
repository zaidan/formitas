#encoding: utf-8
module Form
  class Field
    class Input
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
