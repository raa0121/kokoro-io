class Profile < ApplicationRecord
  extend FriendlyId
  friendly_id :screen_name, use: [ :finders ]

  belongs_to :publisher, polymorphic: true
  validates :display_name, :screen_name, presence: true
  validates :available, inclusion: {in: [true, false]}
  validates :screen_name, uniqueness: true
  validates :screen_name, length: { maximum: 64 }


  attachment :avatar, destroy: false
  has_many :messages

  def type
    publisher_type.downcase.to_sym
  end

  def available?
    available
  end

  def unavailable?
    !available?
  end
end
