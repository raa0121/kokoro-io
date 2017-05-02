class URLMessageFilter < ApplicationMessageFilter
  URL_REGEX = %r`(https?://[^\s$]+)`

  YOUTUBE_FULL_REGEX = %r`https?://(?:www)?\.youtube\.com/watch\?v=([a-zA-Z0-9\-_]+)([^\s]*)(?:\s|$)`
  YOUTUBE_SHORT_REGEX = %r`https?://youtu\.be/([a-zA-Z0-9\-_]+)([^\s]*)(\s|$)`
  YOUTUBE_REGEX = Regexp.union(YOUTUBE_FULL_REGEX, YOUTUBE_SHORT_REGEX)

  DROPLR_IMAGE_REGEX = %r`(https?://d\.pr/i/[0-9a-zA-Z]+)(\s|$)`
  GYAZO_IMAGE_REGEX = %r`(https?://gyazo\.com/[0-9a-z]+)(\s|$)`
  IMGUR_IMAGE_REGEX = %r`https?://imgur\.com/([0-9a-zA-Z]+)(\s|$)`

  IMAGE_REGEX = %r`(https?://[^\s]+\.(?:jpg|JPG|jpeg|JPEG|png|PNG|gif|GIF)(?:#[^\s]*|\?[^\s]*)?)(?:$|\s|")`

  def self.filter(text)
    text.gsub(URL_REGEX) { |s|
      if ( m = s.match(YOUTUBE_REGEX) )
        %`<div><iframe width="560" height="315" src="https://www.youtube.com/embed/#{m[1]}" frameborder="0" allowfullscreen></iframe></div>`
      elsif ( m = s.match(IMGUR_IMAGE_REGEX) )
        %`<div><a class="img-thumbnail" href="https://imgur.com/#{m[1]}" target="_blank"><img class="thumb" src="https://i.imgur.com/#{m[1]}.png" /></a></div>`
      elsif ( m = s.match(DROPLR_IMAGE_REGEX) )
        %`<div><a class="img-thumbnail" href="#{m[1]}" target="_blank"><img class="thumb" src="#{m[1]}+" /></a></div>`
      elsif ( m = s.match(IMAGE_REGEX) )
        %`<div><a class="img-thumbnail" href="#{m[1]}" target="_blank"><img class="thumb" src="#{m[1]}" /></a></div>`
      else
        %`<a href="#{s}" target="_blank">#{s}</a>`
      end
    }
  end
end
