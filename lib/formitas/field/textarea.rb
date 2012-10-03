#encoding: utf-8
module Formitas
  class Field
    # Represent a HTML textarea
    class Textarea < Field
      attribute :type,String

      def input_tag
        content_tag(
          :textarea,
          escape_html(html_value),
          :name => html_name,
          :id => html_id
        )
      end
    end
  end
end
