module ApplicationHelper

  def icon name, space = ' '
    raw %`<span class="glyphicon glyphicon-#{name}"></span>#{space}`
  end

  def link_with_icon_to title, icon_name, *args
    link_to raw("#{icon icon_name}#{title}"), *args
  end

  def caret lspace = ' ', rspace = ''
    raw %`#{lspace}<span class="caret"></span>#{rspace}`
  end

end
