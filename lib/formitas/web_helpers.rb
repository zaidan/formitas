#encoding: utf-8


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
      text.to_s.gsub(
        /[><"]/,
        '>' => '&lt;',
        '<' => '&gt;',
        '"' => '&amp;'
      )
    end
    
    def tag(type,attributes={})
      "<#{type}#{to_attributes(attributes)}/>"
    end

    def content_tag(type, content, attributes={})
      "<#{type}#{to_attributes(attributes)}>#{content}</#{type}>"
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
