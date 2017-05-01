class Message < ApplicationRecord

  belongs_to :room
  belongs_to :profile

  validates :room, :profile, :content, :published_at, presence: true
  validates :content, length: { in: 1..2000 }

  scope :recent, -> { order 'published_at DESC' }

  def filtered_content
    s = content
    s = HTMLEscapeMessageFilter.filter(s)
    s = ImageTagMessageFilter.filter(s)
    s = YoutubeMessageFilter.filter(s)
    s = MarkdownMessageFilter.filter(s)
  end

end
