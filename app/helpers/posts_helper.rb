module PostsHelper
  def markup(type, str)
    case type.downcase.to_sym
      when :b
        "<b>#{str}</b>"
      when :u
        "<u>#{str}</u>"
      when :h3
        "<h3>#{str}</h3>"
      when :h4
        "<h4>#{str}</h4>"
      when :code
        "<div class=\"code\">#{str}</div>"
      else
        str
    end
  end

  def markup_with_parameter(type, value, str)
    case type.downcase.to_sym
      when :a
        "<a href=\"#{value}\">#{str}</a>"
    end
  end

  def bb(str)
    resultString = h(str).gsub(/\[(.+?)\](.+?)\[\/\1\]/) { |m| markup($1, $2) }
    resultString.gsub!(/\[(.+?)\b v=(.+?)\](.+?)\[\/\1\]/) { |m| markup_with_parameter($1, $2, $3) }
    resultString.gsub("\n", "<br />")
  end

  private :markup, :markup_with_parameter
end
