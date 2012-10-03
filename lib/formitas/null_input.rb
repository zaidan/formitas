#encoding: utf-8
module Formitas
  # Null input controller
  class NullInput
    
    # Test if input is valid
    #
    # @return [true]
    #   returns allways true
    # 
    # @api private
    #
    def self.valid?
      true
    end

    # Return input hash
    #
    # @return [Hash]
    #   returns allways empty hash
    # 
    # @api private
    #
    def self.input_hash
      {}
    end
  end
end
