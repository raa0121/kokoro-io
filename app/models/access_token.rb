require 'securerandom'
require 'digest/sha2'

class AccessToken < ApplicationRecord

  belongs_to :user
  delegate :screen_name, to: :user, prefix: true
  validates :user, :name, :token, presence: true
  validates :token, uniqueness: true
  validates :essential, inclusion: {in: [true, false]}

  def self.generate_token
    Digest::SHA256.hexdigest "#{ENV['TOKEN_SALT']}_#{SecureRandom.uuid}"
  end

  def masked_token
    token.gsub(/./, '*')
  end

  def essential?
    essential
  end

end
