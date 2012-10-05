#encoding: utf-8

require 'rack'
require 'i18n'

module Formitas
  # Web helpers to ease the generation of html
  module WebHelpers
    def escape_url(url)
      Rack::Utils.escape(url)
    end

    def translate(*args)
      I18n.translate(*args)
    end

    def escape_html(text)
      Rack::Utils.escape_html(text)
    end
    
    def tag(type,attributes={})
      "<#{type}#{to_attributes(attributes)}/>"
    end
    
    def content_tag(type,content,attributes={})
      "<#{type}#{to_attributes(attributes)}>#{content}</#{type}>"
    end

    def wrap_html_values(values,tag)
      values.each do |item|
        item = yield item if block_given?
        content_tag(tag, item)
      end.join('')
    end

    def to_attributes(attributes)
      if attributes.empty?
        ""
      else
        " #{attributes.map {|k, v| %{#{k}="#{escape_html(v)}"} }.join(' ')}"
      end
    end
  end
end
