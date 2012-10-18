require 'adamantium'
require 'inflector'
require 'anima'
require 'rack'
require 'i18n'
require 'aequitas'

module Formitas

  Undefined = Object.new.freeze

  class Values
    include AbstractClass

    Empty = Class.new(self) do
      def get(name)
        Undefined
      end
    end.new.freeze

    class Proxy
      def initialize(object)
        @object = object
      end

      def get(name)
        @object.public_send(name)
      end
    end
  end

  # Return translation
  #
  # I18n interface does not support :default on multi lookups so we do 
  # it externally
  #
  # @param [Array] lookups
  # @param [Hash] options
  #
  # @return [String]
  #   if translation could be found
  #
  # @return [Undefined] 
  #   otherwise
  #
  # @api private
  #
  def self.translate(lookups, options={})
    lookups.each do |lookup|
      result = I18n.translate(lookup, options.merge(:default => Undefined))
      return result unless result.equal?(Undefined)
    end

    Undefined
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
      def valid?; true; end
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
end

require 'formitas/html'
require 'formitas/context'
require 'formitas/renderer'
require 'formitas/renderer/context'
require 'formitas/renderer/context/form'
require 'formitas/renderer/field'
require 'formitas/renderer/field/input'
require 'formitas/renderer/violation'
require 'formitas/renderer/violation_set'

require 'formitas/field'
