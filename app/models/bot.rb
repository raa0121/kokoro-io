class Bot < ApplicationRecord
  extend FriendlyId
  friendly_id :bot_name, use: [ :finders ]

  belongs_to :user
  has_one :profile, as: :publisher
  delegate :screen_name, to: :profile, prefix: true
  delegate :display_name, to: :profile, prefix: true
  has_many :memberships, as: :memberable
  has_many :rooms, through: :memberships

  validates :user, :bot_name, :screen_name, :access_token, :status, presence: true
  validates :bot_name, friendly_id: true
  validates :bot_name, length: { maximum: 255 }
  validates :bot_name, uniqueness: true
  validates :access_token, uniqueness: true
  validates :screen_name, length: { maximum: 64 }

  enum status: {
    enabled: 10,
    disabled: 20
  }

  def name
    bot_name
  end

  def self.generate_token
    Digest::SHA256.hexdigest "#{ENV['TOKEN_SALT']}_#{SecureRandom.uuid}"
  end

  def owner? user
    self.user == user
  end

end
