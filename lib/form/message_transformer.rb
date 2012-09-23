#encoding: utf-8
module Form
  # Method object for message translation
  class MessageTransformer < Aequitas::MessageTransformer
    include Immutable
    
    # Transforms the specified Violation to an translated error message string
    #
    # @param [Violation] violation
    # The Violation to transform
    #
    # @return [String]
    # The transformed message
    #
    # @api private
    #
    def self.transform(violation)
      klass = [:length_between,:blank].include?(violation.type) ? Aequitas : self
      klass.new(violation).translation
    end

    # Result of translation
    #
    # @return [String]
    # The translated message
    #
    # @api private
    #
    attr_reader :translation

  private
    
    # Initialize message translation object and calculates translation
    #
    # @param [Violation] violation
    # The Violation to transform
    #
    # @return [undefined]
    # The transformed message
    #
    # @api private
    #
    def initialize(violation)
      @violation = violation
      @translation = translate
    end

    # Translate violation error
    #
    # @return [String]
    # The translated message
    #
    # @api private
    #
    def translate
      ::I18n.translate(violation.type, options.merge(violation.info))
    end
    memoize :translate

    # Options for translation scope
    #
    # @return [Hash]
    #
    # @api private
    #
    def options
      {
        :attribute => attribute,
        :value     => value,
        :scope     => scope
      }
    end
    memoize :options

    # Return violation
    #
    # @return [Violation]
    #
    # @api private
    #
    def violation
      @violation
    end
    memoize :violation

    # Return violation resource
    #
    # @return [Resource]
    #
    # @api private
    #
    def resource
      violation.resource
    end
    memoize :resource

    # Return model name
    #
    # @return [String]
    #
    # @api private
    #
    def model_name
      resource.class.name.split('::').last.downcase
    end
    memoize :model_name

    # Return attribute name
    #
    # @return [String]
    #
    # @api private
    #
    def attribute_name
      violation.attribute_name
    end
    memoize :attribute_name

    # Return default scope
    #
    # @return [Array<String>]
    #
    # @api private
    #
    def default_scope
      [model_name,attribute_name]
    end
    memoize :default_scope

    # Return validation attribute value
    #
    # @return [String]
    #
    # @api private
    #
    def value
      resource.validation_attribute_value(attribute_name)
    end
    memoize :value

    # Return base scope
    #
    # @return [Array<String>]
    #
    # @api private
    #
    def base_scope
      default_scope
    end
    memoize :base_scope
    
    # Return translation key
    #
    # @return [Symbol]
    #
    # @api private
    #
    def key
      :name
    end
    memoize :key

    # Return translated attribute
    #
    # @return [String]
    #
    # @api private
    #
    def attribute
      ::I18n.t(key, :scope => default_scope)
    end
    memoize :attribute

    # Return scope
    #
    # @return [Array<String>]
    #
    # @api private
    #
    def scope
      base_scope + [:violation]
    end
    memoize :scope
  end
end
