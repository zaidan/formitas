require 'adamantium'
require 'inflector'
require 'anima'
require 'rack'
require 'i18n'

module Formitas

  # Abstract class for a form field without 
  class Field
    include Anima, AbstractClass, Adamantium

    attribute :name

    def self.build(name, options = {})
      new(options.merge(:name => name))
    end

    class Input < self
    end

    class Select < self
      attribute :collection
    end

    class Checkbox < self
    end
  end

  class Values
    class Empty
    end
  end

  module Validator
    EmptyViolationSet = Class.new do
      include Adamantium
      def inspect; self.class.name; end
      def on(name); []; end
      def self.name; 'Formitas::Validator::EmptyViolationSet'; end
    end.new

    Valid = Class.new do
      include Adamantium
      def inspect; self.class.name; end
      def violations; EmptyViolationSet; end
      def self.name; 'Formitas::Validator::Valid'; end
    end.new
  end

  class FieldSet
    include Enumerable

    def initialize(fields=[])
      @index = {}
      fields.each do |field|
        add(field)
      end
    end

    def each(&block)
      @index.values.each(&block)
    end

    def get(name)
      @index.fetch(name)
    end

    def add(field)
      @index[field.name] = field
      self
    end
  end

  class Context
    include Anima, Adamantium

    attribute :name
    attribute :fields
    attribute :values
    attribute :validator

    def error?
      !validator.valid?
    end

    def violations
      validator.violations
    end

    def update(attributes)
      self.class.new(self.attributes.merge(attributes))
    end

    class Body < self
    end

    class Form < self
      include Anima, Adamantium

      attribute :action
      attribute :method
      attribute :enctype

      # Return form renderer
      #
      # @return [Renderer::Form]
      #
      # @api private
      #
      def renderer
        Renderer::Context::Form.new(self)
      end
      memoize :renderer
    end
  end
end

require 'formitas/web_helpers'
require 'formitas/renderer'
require 'formitas/renderer/context'
require 'formitas/renderer/field'
require 'formitas/renderer/violation'
require 'formitas/renderer/violation_set'
