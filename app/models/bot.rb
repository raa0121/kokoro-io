class Bot < ActiveRecord::Base
  belongs_to :user
  has_many :memberships, as: :memberable
  has_many :rooms, through: :memberships
end
