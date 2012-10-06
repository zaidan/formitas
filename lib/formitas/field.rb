#encoding: utf-8
module Formitas
  # Abstract base class for form fields
  class Field
    include Anima, WebHelpers, AbstractClass, Immutable

    attribute :name
    attribute :basename
    attribute :input
    attribute :violations

    # Return Field as HTML content
    #
    # @param [Symbol] tag_name
    #   html content tag name
    #
    # @return [String]
    #   with rendered HTML content
    # 
    # @api private  
    #
    def render(tag_name = :div)
      contents = [
        label_tag,
        input_tag,
        error_tag
      ]
      content_tag(tag_name, contents.join(''), :class => :input)
    end
    memoize :render

    # Return HTML input tag
    #
    # @return [String]
    #   with HTML input tag
    # 
    # @api private  
    #
    abstract_method :input_tag

  private

    # Return html attributes
    #
    # @return [Hash]
    #
    # @api private
    #
    def html_attributes
      {
        :name  => html_name,
        :id    => html_id
      }
    end
    
    # Return HTML id
    #
    # @return [String]
    #   with HTML id
    # 
    # @api private  
    #
    def html_id
      "#{basename}_#{name}"
    end
    memoize :html_id

    # Return HTML name
    #
    # @return [String]
    #   with HTML name
    # 
    # @api private  
    #
    def html_name
      "#{basename}[#{name}]"
    end
    memoize :html_name


    # Return HTML value
    #
    # @return [String]
    #   with HTML value
    # 
    # @api private  
    #
    abstract_method :html_value

    # Return localized HTML label
    #
    # @return [String]
    #   with HTML label
    # 
    # @api private  
    #
    def label
      translate(:label, :scope => [basename, name])
    end
    memoize :label

    # Return HTML label tag
    #
    # @return [String]
    #   with HTML label tag
    # 
    # @api private  
    #
    def label_tag
      content_tag(:label, label, :for => html_id)
    end
    memoize :label_tag

    # Return errors as HTML code
    #
    # @return [String]
    #   when input is not valid
    #
    # @return [nil]
    #   otherwise 
    # 
    # @api private  
    #
    def error_tag
      Dumper::Errors.dump(violations, html_id) unless input.valid?
    end
    memoize :error_tag
  end
end
