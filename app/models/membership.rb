class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  validates :authority, presence: true
  enum authority: {
    member: 10,
    maintainer: 20,
    admin: 100
  }

  before_validation :bind_default_values

  private
  def bind_default_values
    self.authority ||= :member
  end
end
