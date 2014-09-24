require 'securerandom'
require 'digest/sha2'

class AccessToken < ActiveRecord::Base
  include CanCan::Ability

  belongs_to :user
  validates :user, :name, :token, presence: true
  validates :token, uniqueness: true
  validates :essential, inclusion: {in: [true, false]}

  def self.generate_token
    Digest::SHA256.hexdigest "#{ENV['TOKEN_SALT']}_#{SecureRandom.uuid}"
  end

  def essential?
    essential
  end

end
