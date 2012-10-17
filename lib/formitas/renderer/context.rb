module Formitas

  class Renderer
    # Abstract base class that renders a context
    class Context < self

      delegate :name

      def value(name)
        object.value(name)
      end

    end
  end
end
