class Bot < ActiveRecord::Base
  belongs_to :user
  has_many :memberships, as: :memberable
  has_many :rooms, through: :memberships

  validates :bot_name, :screen_name, :access_token, :status, presence: true
  validates :bot_name, format: { with: /[0-9a-z][0-9a-z-_]+/ }
  validates :bot_name, length: { in: 1..255 }
  validates :bot_name, uniqueness: true
  validates :screen_name, length: { in: 2..64 }

  enum status: {
    enabled: 10,
    disabled: 20
  }
end
