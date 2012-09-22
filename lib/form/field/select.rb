#encoding: utf-8
module Form
  class Field
    class Select < Field
      attribute :collection,   Object
      attribute :value_method, Symbol
      attribute :name_proc,    Proc

      def input_tag
        content_tag(:select,option_html,:id => html_id,:name => html_name)
      end
    
    private

      def option_html
        option_tags.join("")
      end

      def option_tags
        collection.map do |resource|
          option_tag_for_resource(resource)
        end
      end

      def option_tag_for_resource(resource)
        value = to_value(resource)

        attributes = { :value => value }

        if value == html_value
          attributes[:selected]=:selected
        end
        content_tag(:option,to_name(resource),attributes)
      end

      def to_name(resource)
        if name_proc
          name_proc.call(resource)
        else
          resource
        end
      end

      def to_value(resource)
        if value_method
          resource.send(value_method).to_s
        else
          resource
        end
      end
    end
  end
end