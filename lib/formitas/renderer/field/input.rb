module Formitas
  class Renderer
    class Field

      # Abstract class for <input> tag fields
      class Input < self

        def input_value
          value = self.value
          value_or_undefined = value
          value_or_undefined.equal?(Undefined) ? '' : value
        end
        memoize :input_value

        def type
          self.class::TYPE
        end

        def input_html
          HTML.input(input_attributes)
        end
        memoize :input_html

        def default_input_attributes
          { 
            :id => html_id, 
            :type => type, 
            :name => input_name
          }
        end

        def input_attributes
          default_input_attributes.merge(extra_input_attributes)
        end

        def extra_input_attributes
          {}
        end

        # Renderer for <input type="text">
        class Text < self
          TYPE = :text

          def extra_input_attributes
            { :value => input_value }
          end
        end

        # Renderer for <input type="checkbox">
        class Checkbox < self
          TYPE = :checkbox

          def input_html
            HTML.join([hidden_html, super])
          end
          memoize :input_html

          def hidden_html
            HTML.input(
              :type => :hidden,
              :name => input_name,
              :value => '0'
            )
          end

          def checked_value
            value ? 'checked' : ''
          end

          def extra_input_attributes
            { :value => '1', :checked => checked_value }
          end
        end
      end
    end
  end
end
