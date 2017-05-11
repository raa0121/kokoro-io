class URLMessageFilter < ApplicationMessageFilter
  URL_REGEX = %r`(https?://[^\s$]+)`

  YOUTUBE_FULL_REGEX = %r`https?://(?:www)?\.youtube\.com/watch\?v=([a-zA-Z0-9\-_]+)([^\s]*)(?:\s|$)`
  YOUTUBE_SHORT_REGEX = %r`https?://youtu\.be/([a-zA-Z0-9\-_]+)([^\s]*)(\s|$)`

  DROPLR_IMAGE_REGEX = %r`(https?://d\.pr/i/[0-9a-zA-Z]+)(\s|$)`
  GYAZO_IMAGE_REGEX = %r`(https?://gyazo\.com/[0-9a-z]+)(\s|$)`
  IMGUR_IMAGE_REGEX = %r`https?://imgur\.com/([0-9a-zA-Z]+)(\s|$)`

  IMAGE_REGEX = %r`(https?://[^\s]+\.(?:jpg|JPG|jpeg|JPEG|png|PNG|gif|GIF)(?:#[^\s]*|\?[^\s]*)?)(?:$|\s|")`

  def self.filter(text)
    html = Nokogiri::HTML.fragment(text)
    html.search('p > a').each do |el|
      el.replace replace_url(el)
    end
    html.to_s
  end

  private
  def self.replace_url(el)
    url = el.attribute('href').value
    t = if ( m = url.match(YOUTUBE_FULL_REGEX) )
      %`<div><iframe width="560" height="315" src="https://www.youtube.com/embed/#{m[1]}" frameborder="0" allowfullscreen></iframe></div>`
    elsif ( m = url.match(YOUTUBE_SHORT_REGEX) )
      %`<div><iframe width="560" height="315" src="https://www.youtube.com/embed/#{m[1]}" frameborder="0" allowfullscreen></iframe></div>`
    elsif ( m = url.match(IMGUR_IMAGE_REGEX) )
      %`<div><a class="img-thumbnail" href="https://imgur.com/#{m[1]}" target="_blank"><img class="thumb" src="https://i.imgur.com/#{m[1]}.png" /></a></div>`
    elsif ( m = url.match(DROPLR_IMAGE_REGEX) )
      %`<div><a class="img-thumbnail" href="#{m[1]}" target="_blank"><img class="thumb" src="#{m[1]}+" /></a></div>`
    elsif ( m = url.match(IMAGE_REGEX) )
      %`<div><a class="img-thumbnail" href="#{m[1]}" target="_blank"><img class="thumb" src="#{m[1]}" /></a></div>`
    else
      el.to_s
    end
    Nokogiri::HTML.fragment(t)
  end
end
