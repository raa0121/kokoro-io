class Profile < ApplicationRecord
  belongs_to :publisher, polymorphic: true
  validates :display_name, :screen_name, presence: true

  attachment :avatar
  has_many :messages, as: :publisher
end