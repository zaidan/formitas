module Formitas
  # Selectable option (does not need to be a <select><option...)

  class Option
    include Anima, Adamantium

    attribute :html_value
    attribute :domain_value

    include Equalizer.new(attribute_set.map(&:name))
  end
end
