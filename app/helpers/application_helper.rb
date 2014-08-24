module ApplicationHelper
  def nl2br(s)
    s.gsub(/\n/, '<br>')
  end

  def encodeHTML(s)
    s.gsub(/&/, '&amp;').gsub(/</, '&lt;').gsub(/"/, '&quot;')
  end
end
