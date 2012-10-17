module Formitas

  # Abstract base class for renderers
  class Renderer
    include Adamantium, WebHelpers

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
    private_class_method :delegate

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
    private_class_method :delegate_method

    delegate :error?

    # Return rendered object
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :object

    # Helper method that yields on error
    #
    # @yield 
    #   if form has error
    #
    # @return [self]
    #
    # @api private
    #
    def on_error
      yield if error?
      self
    end

  private

    # Initialize object
    #
    # @param [Object] object
    #
    # @api private
    #
    def initialize(object)
      @object = object 
    end
  end
end
