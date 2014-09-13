class Room < ActiveRecord::Base

  validates :room_name, :screen_name, presence: true
  validates :room_name, length: { in: 1..255 }
  validates :screen_name, length: { in: 2..64 }
  validates :private, inclusion: {in: [true, false]}

  has_many :messages
  has_many :memberships
  has_many :users, through: :memberships

  def private?
    private
  end

end
