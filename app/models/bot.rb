class Bot < ApplicationRecord

  belongs_to :user
  has_one :profile, as: :publisher
  delegate :screen_name, to: :profile, prefix: false
  delegate :display_name, to: :profile, prefix: false
  delegate :messages, to: :profile, prefix: false
  delegate :avatar, to: :profile, prefix: false
  has_many :memberships, as: :memberable
  has_many :rooms, through: :memberships

  validates :user, :access_token, :status, presence: true
  validates :access_token, uniqueness: true
  validates :screen_name, length: { maximum: 64 }

  enum status: {
    enabled: 10,
    disabled: 20
  }

  def name
    display_name
  end

  def self.generate_token
    Digest::SHA256.hexdigest "#{ENV['TOKEN_SALT']}_#{SecureRandom.uuid}"
  end

  def owner? user
    self.user == user
  end

end
