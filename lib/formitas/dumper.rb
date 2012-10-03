module Formitas
  # Dumper base class
  class Dumper < ::Dumper
    include AbstractClass, WebHelpers
  end
end
