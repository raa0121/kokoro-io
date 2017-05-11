class Message < ApplicationRecord

  belongs_to :room
  belongs_to :profile

  validates :room, :profile, :content, :published_at, presence: true
  validates :content, length: { in: 1..2000 }

  scope :recent, -> { order 'id DESC' }

  def filtered_content
    filters.inject(content) { |s, f|
      f.send(:filter, s)
    }
  end

  private
  def filters
    [
      MarkdownMessageFilter,
      URLMessageFilter,
      RoomNameMessageFilter
    ]
  end

end
