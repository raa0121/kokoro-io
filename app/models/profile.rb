class Profile < ApplicationRecord
  extend FriendlyId
  friendly_id :screen_name, use: [ :finders ]

  belongs_to :publisher, polymorphic: true
  validates :display_name, :screen_name, presence: true

  attachment :avatar, destroy: false
  has_many :messages, as: :publisher
end
