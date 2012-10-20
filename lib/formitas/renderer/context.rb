module Formitas

  class Renderer
    # Abstract base class that renders a context
    class Context < self

      delegate :name
      delegate :valid?
      delegate :domain_value
      delegate :html_value
    end
  end
end
