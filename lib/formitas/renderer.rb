module Formitas

  # Abstract base class for renderers
  class Renderer
    include Adamantium, AbstractClass

    # Render object
    #
    # @api private
    # 
    # @return [Object]
    #
    def self.render(*args)
      new(*args).render
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
        def #{name}(*args)
          @object.#{name}(*args)
        end
      RUBY
    end
    private_class_method :delegate_method


    # Return rendered object
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :object
    private :object

    # Return rendering context
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :context
    private :context

    abstract_method :render

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
      yield unless valid?
      self
    end

    abstract_method :valid?

  private

    # Initialize object
    #
    # @param [Object] object
    # @param [Object] context
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(object, context = Undefined)
      @object, @context = object, context
    end
  end
end
