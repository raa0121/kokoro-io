class YoutubeMessageFilter < ApplicationMessageFilter
  YOUTUBE_FULL_URL_REGEX = %r`https?://(?:www)?\.youtube\.com/watch\?v=([a-zA-Z0-9\-_]+)([^\s]*)(?:\s|$)`
  YOUTUBE_SHORT_URL_REGEX = %r`https?://youtu\.be/([a-zA-Z0-9\-_]+)([^\s]*)(\s|$)`
  YOUTUBE_URL_REGEX = Regexp.union(YOUTUBE_FULL_URL_REGEX, YOUTUBE_SHORT_URL_REGEX)
  def self.filter(text)
    text.gsub(YOUTUBE_URL_REGEX) { |s|
      m = s.match YOUTUBE_URL_REGEX
      id = m[1]
      %`<div><iframe width="560" height="315" src="https://www.youtube.com/embed/#{id}" frameborder="0" allowfullscreen></iframe></div>`
    }
  end
end
