module ApplicationHelper

  def icon_gi name, space = ' '
    raw %`<span class="glyphicon glyphicon-#{name}"></span>#{space}`
  end

  def link_with_icon_to title, icon_name, *args
    link_to raw("#{icon icon_name}#{title}"), *args
  end

  def caret lspace = ' ', rspace = ''
    raw %`#{lspace}<span class="caret"></span>#{rspace}`
  end

  def kakkoii_catch_copy
    [
    'おそらく最もプログラマブルなチャットサービス（おそらく）',
    'かなりすごい（かなり）',
    'どうみてもチャットサービス（どうみても）',
    'しごとをやめて、チャットをしよう',
    ].sample
  end

end
