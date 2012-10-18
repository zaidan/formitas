module Formitas
  class Renderer
    # Abstract base class for label renderers
    class Label < self
      # Label renderer that returns html values
      class HTMLValue < self
        def self.render(object)
          object.html_value
        end
      end

      # Label renderer that returns domain values
      class DomainValue < self
        def self.render(object)
          object.domain_value
        end
      end

      # Label renderer that delegates to block
      class Block < self
        def initialize(&block)
          @block = block
        end

        def render(object)
          @block.call(object)
        end
      end
    end
  end
end
