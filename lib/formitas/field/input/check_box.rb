#encoding: utf-8
module Formitas
  class Field
    class Input
      # Represent a HTML checkbox
      class CheckBox < self
        def input_tag
          hidden_tag + tag(:input,attributes)
        end
        
      private

        def attributes
          attributes = {
            :type => :checkbox,
            :name => html_name,
            :value => '1',
            :id => html_id,
            :checked => checked_value
          }
        end

        def checked_value
          if checked?
            :checked
          end
        end

        def checked?
          html_value == '1'
        end

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
