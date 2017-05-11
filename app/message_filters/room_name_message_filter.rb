class RoomNameMessageFilter < ApplicationMessageFilter

  def self.filter(text)
    html = Nokogiri::HTML.fragment(text)
    html.search('p > text()').each do |el|
      el.replace replace_room_name(el.to_s)
    end
    html.to_s
  end

  def self.replace_room_name(text)
    r = %r`#((?:[0-9a-z_]+\/)?[0-9a-z_]+)`
    text.gsub(r) { |m|
      name = m[1..-1]
      %`<a href="/r/@#{name}" target="_blank">##{name}</a>`
    }
  end

end
