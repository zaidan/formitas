module Formitas
  # Abstract dumper base class
  class Dumper
    include AbstractClass, Immutable
    
    # Return dump
    #
    # @return [Hash]
    #   the dumped representation
    #
    # @api private
    #
    abstract_method :dump

    # Convert object to dump
    #
    # @return [Hash]
    #   dumped hash
    #
    # @api private
    #
    def self.dump(*args)
      new(*args).dump
    end

    # Dump multiple items
    # 
    # @param [Enumerable] items
    #   items to dump
    # @param [Array] args
    #   arguments to initialize dumper
    #
    # @return [undefined]
    # 
    # @api private
    # 
    def self.dump_items(items, *args)
      items.map do |item|
        dump(item, *args)
      end
    end

  private

    # Initialize dumper
    # 
    # @param [Object] object
    #
    # @return [undefined]
    # 
    # @api private
    # 
    def initialize(object)
      @object = object
    end

    # Return object to dump
    #
    # @return [Object]
    #
    # @pai private
    #
    attr_reader :object
    private :object
  end
end
