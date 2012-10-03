#encoding: utf-8
module Formitas
  # Represent a HTML form field
  class Field
    include Virtus::ValueObject, WebHelpers, AbstractClass, Immutable

    attribute :name,  Symbol
    
    attribute :basename,  Symbol
    
    attribute :input, Object, :default => NullInput
    
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

  private

    # Return HTML input tag
    #
    # @return [String]
    #   with HTML input tag
    # 
    # @api private  
    #
    abstract_method :input_tag
    
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
    def html_value
      input_hash[input_hash_key]
    end
    memoize :html_value

    # Return input hash key
    #
    # @return [String]
    #   with valid hash key if input was found
    # @return [nil]
    #   otherwise
    # 
    # @api private  
    #
    def input_hash_key
      input_hash.keys.detect { |key| key.to_sym == name.to_sym }
    end
    memoize :input_hash_key

    # Return input hash
    #
    # @return [Hash]
    #   input hash
    # 
    # @api private  
    #
    def input_hash
      input.input_hash
    end
    memoize :input_hash
    
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
      Dumper::Errors.dump(input.errors.on(name), html_id) unless input.valid?
    end
  end
end
