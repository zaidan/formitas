#encoding: utf-8

module Formitas

  # helpers to ease the generation of html
  module HTML

    # An html fragment
    class Fragment
      include Adamantium, Equalizer.new(:to_s)

      def initialize(string)
        @string = string.dup.freeze
      end

      def to_s
        @string
      end

      # Return fragment is html safe
      #
      # @return [String]
      #
      # @api private
      #
      def html_safe?; true; end

      # Create new fragment
      #
      # @param [String,Fragment] 
      #  
      # @return [Fragment]
      #
      # @api private
      #   
      def self.build(input)
        unless input.kind_of?(self)
          new(HTML.escape(input))
        else
          input
        end
      end
    end

    # Join html compoinents
    #
    # @param [Enumerable<#to_s>] components
    #
    # @return [HTML::Fragment]
    #
    # @api private
    #
    def self.join(components)
      contents = components.map { |component| Fragment.build(component).to_s }
      Fragment.new(contents.join(''))
    end


    # Escape html
    #
    # @param [String] text
    #
    # @return [String]
    #
    # @api private
    #
    def self.escape(text)
      text.to_s.gsub(
        /[><"]/,
        '>' => '&lt;',
        '<' => '&gt;',
        '"' => '&amp;'
      )
    end

    %w(li div label select option textarea).each do |name|
      class_eval(<<-RUBY, __FILE__, __LINE__)
        def self.#{name}(*args)
          content_tag(:#{name}, *args)
        end
      RUBY
    end

    %w(input).each do |name|
      class_eval(<<-RUBY, __FILE__, __LINE__)
        def self.#{name}(*args)
          tag(:#{name}, *args)
        end
      RUBY
    end

    # Create contentless html tag
    #
    # @param [#to_str] type
    # @param [Hash] attributes
    #
    # @return [Fragment]
    #
    # @api private
    #
    def self.tag(type, attributes={})
      Fragment.new("<#{type}#{attributes(attributes)}/>")
    end

    # Create content tag 
    #
    # @param [#to_str] type
    # @param [String] content
    #
    # @return [Fragment]
    #
    # @api private
    #
    def self.content_tag(type, content, attributes={})
      Fragment.new("<#{type}#{attributes(attributes)}>#{Fragment.build(content).to_s}</#{type}>")
    end

    # Create html attributes
    #
    # @param [Hash] attributes
    #
    # @return [String]
    #
    # @api private
    #
    def self.attributes(attributes)
      return '' if attributes.empty?

      contents = attributes.map do |key, value|
        %Q{ #{key}="#{escape(value)}"} 
      end.join('')
    end
  end
end
