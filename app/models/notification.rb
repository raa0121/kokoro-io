class Notification < ApplicationRecord
  belongs_to :user
  validates :user, :title, :message, :redirect_url, :image_url, presence: true
  validates :read, inclusion: {in: [true, false]}
end
