require 'rails_helper'

RSpec.describe Message, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { user.profile }
  let(:room) { user.chattable_rooms.first }
  let(:message) {
    content = <<-EOS
#Heading1
# Heading2
#    Heading3
#room_name1
#group/room_name2
aaa
bbb
https://example.com/
https://example.com/moge_hoge/foo_bar/baz
https://example.com/image.png
ccc
ddd
_text1_
*text2*
    EOS
    room.messages.create(
      profile: profile,
      content: content,
      published_at: Time.now
    )
  }
  let(:filtered_content) { message.filtered_content }

  describe 'フィルターを適用したメッセージは' do

    it 'URL をアンカータグに変換する' do
      expect(filtered_content).to include('<a href="https://example.com/" target="_blank">https://example.com/</a>')
      expect(filtered_content).to include('<a href="https://example.com/moge_hoge/foo_bar/baz" target="_blank">https://example.com/moge_hoge/foo_bar/baz</a>')
    end

    it '画像 URL を img タグに変換する' do
      expect(filtered_content).to include('<div><a class="img-thumbnail" href="https://example.com/image.png" target="_blank"><img class="thumb" src="https://example.com/image.png"></a></div>')
    end

    it 'イタリック変換をかけない' do
      expect(filtered_content).to include('_text1_')
    end

    it '強調変換をかけない' do
      expect(filtered_content).to include('*text2*')
    end

    it 'ホワイトスペースがない場合は見出し変換をかけない' do
      expect(filtered_content).to include('#Heading1')
    end

    it 'ルーム名をアンカータグに変換する' do
      expect(filtered_content).to include('<a href="/r/@room_name1" target="_blank">#room_name1</a>')
      expect(filtered_content).to include('<a href="/r/@group/room_name2" target="_blank">#group/room_name2</a>')
    end

  end
end
