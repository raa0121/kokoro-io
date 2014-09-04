class AccessToken < ActiveRecord::Base
  belongs_to :user
  validates :user, :name, :token, presence: true
  validates :token, uniqueness: true
end
