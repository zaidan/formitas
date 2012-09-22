#encoding: utf-8
module Form
  class Field
    class Input < Field

      def input_tag
        tag(
          :input,
          :type => type,
          :name => html_name,
          :value => html_value,
          :id => html_id
        )
      end

    private

      def type
        :text
      end
    end
  end
end
