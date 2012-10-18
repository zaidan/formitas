module Formitas
  class Renderer
    class Label < self
      class HTMLValue < self
        def self.render(object)
          object.html_value
        end
      end
    end
  end
end
