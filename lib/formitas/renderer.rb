module Formitas

  # Abstract base class for renderers
  class Renderer
    include Adamantium, WebHelpers

    # Return rendered object
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :object

    # Initialize object
    #
    # @param [Object] object
    #
    # @api private
    #
    def initialize(object)
      @object = object 
    end

    # Define delegators
    #
    # @param [Symbol] *names
    #
    # @return [self]
    #
    # @api private
    #
    def self.delegate(*names)
      names.each do |name|
        delegate_method(name)
      end
    end

    # Define delegator
    #
    # @param [Symbol] name
    #
    # @return [self]
    #
    # @api private
    #
    def self.delegate_method(name)
      class_eval(<<-RUBY, __FILE__, __LINE__+1)
        def #{name}
          @object.#{name}
        end
      RUBY
    end
  end
end
