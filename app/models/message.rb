class Message < ApplicationRecord

  belongs_to :room
  belongs_to :publisher, polymorphic: true

  validates :room, :publisher, :content, :published_at, presence: true
  validates :content, length: { in: 1..2000 }

  scope :recent, -> { order 'published_at DESC' }

end
