module HTMLHelper
  def compress(lines)
    lines.split("\n").map { |line| line.gsub(/^\s+/,'') }.join("\n")
  end

  def split_html(html)
    compress(html.split('><').join(">\n<"))
  end
end
