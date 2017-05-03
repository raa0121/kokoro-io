class Message < ApplicationRecord

  belongs_to :room
  belongs_to :profile

  validates :room, :profile, :content, :published_at, presence: true
  validates :content, length: { in: 1..2000 }

  scope :recent, -> { order 'id DESC' }

  def filtered_content
    s = content
    s = HTMLEscapeMessageFilter.filter(s)
    s = URLMessageFilter.filter(s)
    s = MarkdownMessageFilter.filter(s)
  end

end
