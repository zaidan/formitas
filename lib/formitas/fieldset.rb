#encoding: utf-8
module Formitas
  # Represent a HTML fieldset
  module Fieldset
    module InstanceMethods
      include WebHelpers
      attr_reader :input
      attr_reader :basename

      # Initialize input
      #
      # @param [Object] input
      #   object that represents and validates the input
      # 
      # @return [undefined]
      # 
      # @api private  
      #
      def initialize(input=NullInput, basename = name)
        @input = input ? input : NullInput
        @basename = basename
      end
      
      # Return rendered content for form field 
      #
      # @param [Symbol] name
      #   name of form field
      #
      # @return [Field]
      #   returns cached form field
      # 
      # @api private  
      #
      def render(name)
        access(name).render
      end 

      # Return rendered content for all fields 
      #
      # @return [String]
      #   returns cached form field
      # 
      # @api private  
      #
      def inputs
        fields.keys.each_with_object([]) do |name, content|
          content << render(name)
        end.join('')
      end

    private

      # Return name of form
      #
      # @return [Symbol]
      #  returns name of form
      # 
      # @api private  
      #
      def name
        self.class.name.split('::').last.downcase.to_sym
      end

      # Return cached form field 
      #
      # @param [Symbol] name
      #   name of form field
      # 
      # @return [Field]
      #   returns cached form field
      # 
      # @api private  
      #
      def access(name)
        cache[name] ||= create_field(*fields.fetch(name))
      end

      # Create form field 
      #
      # @param [Class] type
      #   type of form to create
      # @param [Hash] attributes
      #   attributes for constructor
      #
      # @return [Field]
      #   returns created form field
      # 
      # @api private  
      #
      def create_field(type, attributes={})
        type.new(attributes.merge(:basename => basename, :input => input))
      end


      # Return cache
      #
      # @return [Hash]
      #   returns cache
      # 
      # @api private  
      #
      def cache
        @cache ||= {}
      end


      # Return fields
      #
      # @return [Hash]
      #   returns fields
      # 
      # @api private  
      #
      def fields
        self.class.fields
      end
    end

    module ClassMethods
      # Return fields
      #
      # @return [Hash]
      #   returns fields
      # 
      # @api private  
      #
      def fields
        @fields ||= {}
      end

      # Create form field 
      #
      # @param [Symbol] name
      #   name of form field
      # @param [Class] type
      #   type of form field
      # @param [Hash] attributes
      #   attributes for constructor
      #
      # @return [self]
      # 
      # @api private  
      #
      def field(name, type, attributes={})
        fields[name]=[type, attributes.merge(:name => name)]

        self
      end

      def inherited(descandant)
        descandant.fields.merge!(fields)
      end

      # Method executed when name can not be resolved to a constant
      #
      # @param [String] name
      #   the module or class that is including this module
      #
      # @return [Class|Module]
      #   returns constant when it can be found under the Formitas namespace
      #   
      # @raise [NameError]
      #   raises NameError otherwise
      #
      # @api private
      #
      def const_missing(name)
        Formitas.const_get(name) 
      end
    end

    # Hook executed when module is included
    #
    # @param [Module|Class] descendant
    #   the module or class that is including this module
    #
    # @return [undefined]
    #
    # @api private
    #
    def self.included(descandant)
      descandant.send(:include, InstanceMethods)
      descandant.send(:extend, ClassMethods)
    end
  end
end
