#encoding: utf-8
module Formitas
  class Field
    include Virtus::ValueObject
    include WebHelpers

    attribute :name,  Symbol
    
    attribute :basename,  Symbol
    
    attribute :input, Object, :default => NullInput
    
    # Return Field as HTML code
    #
    # @return [String]
    #   returns HTML code
    # 
    # @api private  
    #
    def render(tag = :div)
      contents = [
        label_tag,
        input_tag,
        error_tag
      ]
      content_tag(tag, contents.join(''), :class => :input)
    end


  private
    
    # Return HTML id
    #
    # @return [String]
    #   returns HTML id
    # 
    # @api private  
    #
    def html_id
      "#{basename}_#{name}"
    end
    
    # Return HTML name
    #
    # @return [String]
    #   returns HTML name
    # 
    # @api private  
    #
    def html_name
      "#{basename}[#{name}]"
    end

    # Return HTML value
    #
    # @return [String]
    #   returns HTML value
    # 
    # @api private  
    #
    def html_value
      input.input_hash.tap do |hash|
        return hash[name.to_sym] || hash[name.to_s]
      end
    end
    
    # Return localized HTML label
    #
    # @return [String]
    #   HTML label
    # 
    # @api private  
    #
    def label
      translate(:label, :scope => [basename, name])
    end

    # Return HTML label tag
    #
    # @return [Hash]
    #   HTML label tag
    # 
    # @api private  
    #
    def label_tag
      content_tag(:label, label, :for => html_id)
    end
    
    # Check if errors should be displayed
    #
    # @return [true]
    #   returns true if input is not valid and field errors exist
    # 
    # @return [false]
    #   returns false otherwise
    # 
    # @api private  
    #
    def display_errors?
      !input.valid? && field_errors?
    end

    # Check if field errors exist
    #
    # @return [true]
    #   returns true if field errors exist
    # 
    # @return [false]
    #   returns false otherwise
    # 
    # @api private  
    #
    def field_errors?
      !field_errors.empty?
    end
    
    # Return field errors
    #
    # @return [Array]
    #   returns field errors
    # 
    # @api private  
    #
    def field_errors
      input.errors.on(name)
    end
    
    # Return errors as HTML code
    #
    # @return [Hash]
    #   returns errors when #display_errors? is true
    #
    # @return [nil]
    #   returns nil otherwise 
    # 
    # @api private  
    #
    def error_tag
      if display_errors? 
        content_tag(
          :div,
          error_contents, 
          {
            :class => :error, 
            :id => "#{html_id}_error"
          }
        )
      end
    end

    # Return error contents as HTML code
    #
    # @return [String]
    #   returns errors when #display_errors? is true
    # 
    # @api private  
    #
    def error_contents
      field_errors.map do |error|
        content_tag(
          :p,
          escape_html(error),
          {
            :class => 'error',
            :id => "#{html_id}_error_msg_#{error_name(error)}"
          }
        )
      end.join('')
    end


    # Return error name for Aequitas rule
    #
    # @return [String]
    #   returns error name
    # 
    # @api private  
    #
    def error_name(error)
      error.rule.violation_type
    end
  end
end
