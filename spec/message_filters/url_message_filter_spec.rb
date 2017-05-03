
require 'rails_helper'

RSpec.describe URLMessageFilter do

  describe 'YouTube タグを正しく挿入する' do
    let(:id) { '-Rf1wE_mmNI' }

    it '標準URLの場合' do
      text = <<-EOS
https://www.youtube.com/watch?v=#{id}
    EOS
      expected = <<-EOS
<div><iframe width="560" height="315" src="https://www.youtube.com/embed/#{id}" frameborder="0" allowfullscreen></iframe></div>
    EOS
expect(URLMessageFilter.filter(text)).to eq(expected)
    end

    it '短縮URLの場合' do
      text = <<-EOS
https://youtu.be/#{id}
    EOS
      expected = <<-EOS
<div><iframe width="560" height="315" src="https://www.youtube.com/embed/#{id}" frameborder="0" allowfullscreen></iframe></div>
    EOS
expect(URLMessageFilter.filter(text)).to eq(expected)
    end

  end

  it 'droplr タグを正しく挿入する' do
    url = 'http://d.pr/i/xxxx'
    text = <<-EOS
#{url}
    EOS
    expected = <<-EOS
<div><a class="img-thumbnail" href="#{url}" target="_blank"><img class="thumb" src="#{url}+" /></a></div>
    EOS
    expect(URLMessageFilter.filter(text)).to eq(expected)
  end

  it 'imgur タグを正しく挿入する' do
    id = 'xxxx'
    text = <<-EOS
https://imgur.com/#{id}
    EOS
    expected = <<-EOS
<div><a class="img-thumbnail" href="https://imgur.com/#{id}" target="_blank"><img class="thumb" src="https://i.imgur.com/#{id}.png" /></a></div>
    EOS
    expect(URLMessageFilter.filter(text)).to eq(expected)
  end

  it 'img タグを正しく挿入する' do
    text = <<-EOS
https://example.com/image.png
    EOS
    expected = <<-EOS
<div><a class="img-thumbnail" href="https://example.com/image.png" target="_blank"><img class="thumb" src="https://example.com/image.png" /></a></div>
    EOS
    expect(URLMessageFilter.filter(text)).to eq(expected)
  end

  it 'a タグを正しく挿入する' do
    url = 'https://example.com/'
    text = <<-EOS
#{url}
    EOS
    expected = <<-EOS
<a href="#{url}" target="_blank">#{url}</a>
    EOS
    expect(URLMessageFilter.filter(text)).to eq(expected)
  end

end
