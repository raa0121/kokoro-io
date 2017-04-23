class Profile < ApplicationRecord
  extend FriendlyId
  friendly_id :screen_name, use: [ :finders ]

  belongs_to :publisher, polymorphic: true
  validates :display_name, :screen_name, presence: true
  validates :available, inclusion: {in: [true, false]}
  validates :screen_name, uniqueness: true


  attachment :avatar, destroy: false
  has_many :messages, as: :publisher
end
