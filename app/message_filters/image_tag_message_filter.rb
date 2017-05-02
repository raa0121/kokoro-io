class ImageTagMessageFilter < ApplicationMessageFilter
  IMAGE_URL_REGEX = %r`(https?://[^\s]+\.(?:jpg|JPG|jpeg|JPEG|png|PNG|gif|GIF)(?:#[^\s]*|\?[^\s]*)?)(?:$|\s)`
  def self.filter(text)
    text.gsub(IMAGE_URL_REGEX) { |s|
      m = s.match(IMAGE_URL_REGEX)
      %`<div><a href="#{m[1]}" target="_blank"><img class="thumb" src="#{m[1]}" /></a></div>`
    }
  end
end
