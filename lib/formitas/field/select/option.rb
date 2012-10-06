#encoding: utf-8
module Formitas
  class Field
    # Represent a HTML input field
    class Select < self
      class Option
        include Anima, Immutable, Equalizer.new(:name, :value)

        attribute :name
        attribute :value

        # Return html text input tag
        #
        # @return [String]
        #
        # @api private
        #
        def html
          tag(:option, :name => name, :value => value)
        end
        memoize :html

      end
    end
  end
end
