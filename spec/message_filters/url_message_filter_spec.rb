
require 'rails_helper'

RSpec.describe URLMessageFilter do

  describe 'YouTube タグを正しく挿入する' do
    let(:id) { '-Rf1wE_mmNI' }

    it '標準URLの場合' do
      text = <<-EOS
<p><a href="https://www.youtube.com/watch?v=#{id}" target="_blank">https://www.youtube.com/watch?v=#{id}</a></p>
    EOS
      expected = <<-EOS
<p><div><iframe width="560" height="315" src="https://www.youtube.com/embed/#{id}" frameborder="0" allowfullscreen></iframe></div></p>
    EOS
expect(URLMessageFilter.filter(text)).to eq(expected)
    end

    it '短縮URLの場合' do
      text = <<-EOS
<p><a href="https://youtu.be/#{id}" target="_blank">https://youtu.be/#{id}</a></p>
    EOS
      expected = <<-EOS
<p><div><iframe width="560" height="315" src="https://www.youtube.com/embed/#{id}" frameborder="0" allowfullscreen></iframe></div></p>
    EOS
expect(URLMessageFilter.filter(text)).to eq(expected)
    end

  end

  it 'droplr タグを正しく挿入する' do
    url = 'http://d.pr/i/xxxx'
    text = <<-EOS
<p><a href="#{url}" target="_blank">#{url}</a></p>
    EOS
    expected = <<-EOS
<p><div><a class="img-thumbnail" href="#{url}" target="_blank"><img class="thumb" src="#{url}+"></a></div></p>
    EOS
    expect(URLMessageFilter.filter(text)).to eq(expected)
  end

  it 'imgur タグを正しく挿入する' do
    id = 'xxxx'
    text = <<-EOS
<p><a href="https://imgur.com/#{id}" target="_blank">https://imgur.com/#{id}</a></p>
    EOS
    expected = <<-EOS
<p><div><a class="img-thumbnail" href="https://imgur.com/#{id}" target="_blank"><img class="thumb" src="https://i.imgur.com/#{id}.png"></a></div></p>
    EOS
    expect(URLMessageFilter.filter(text)).to eq(expected)
  end

  it 'img タグを正しく挿入する' do
    text = <<-EOS
<p><a href="https://example.com/image.png" target="_blank">https://example.com/image.png</a></p>
    EOS
    expected = <<-EOS
<p><div><a class="img-thumbnail" href="https://example.com/image.png" target="_blank"><img class="thumb" src="https://example.com/image.png"></a></div></p>
    EOS
    expect(URLMessageFilter.filter(text)).to eq(expected)
  end

  it 'a タグを正しく挿入する' do
    url = 'https://example.com/'
    text = <<-EOS
<p><a href="#{url}" target="_blank">#{url}</a></p>
    EOS
    expected = <<-EOS
<p><a href="#{url}" target="_blank">#{url}</a></p>
    EOS
    expect(URLMessageFilter.filter(text)).to eq(expected)
  end

end
