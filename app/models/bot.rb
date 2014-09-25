class Bot < ActiveRecord::Base
  extend FriendlyId
  friendly_id :bot_name, use: [ :finders ]

  belongs_to :user
  has_many :memberships, as: :memberable
  has_many :rooms, through: :memberships

  validates :bot_name, :screen_name, :access_token, :status, presence: true
  validates :bot_name, format: { with: /[0-9a-z][0-9a-z\-_]+/ }
  validates :bot_name, length: { in: 1..255 }
  validates :bot_name, uniqueness: true
  validates :access_token, uniqueness: true
  validates :screen_name, length: { in: 2..64 }

  enum status: {
    enabled: 10,
    disabled: 20
  }

  def self.generate_token
    Digest::SHA256.hexdigest "#{ENV['TOKEN_SALT']}_#{SecureRandom.uuid}"
  end

  def owner? user
    self.user == user
  end

end
