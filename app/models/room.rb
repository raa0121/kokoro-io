class Room < ActiveRecord::Base
  extend FriendlyId
  friendly_id :room_name

  validates :room_name, :screen_name, :description, presence: true
  validates :room_name, format: { with: /[0-9a-z][0-9a-z-_]+/ }
  validates :room_name, length: { in: 1..255 }
  validates :room_name, uniqueness: true
  validates :screen_name, length: { in: 2..64 }
  validates :description, length: { in: 1..1000 }
  validates :private, inclusion: {in: [true, false]}

  has_many :messages
  has_many :memberships
  has_many :users, { through: :memberships, source: :user },
    ->{ where(memberable_type: 'User') }
  has_many :bots, { through: :memberships, source: :bot },
    -> { where memberable_type: 'Bot' }

  accepts_nested_attributes_for :users

  scope :public_rooms, -> { where private: false }
  scope :private_rooms, -> { where private: true }

  def private?
    private
  end

  def public?
    !private?
  end

  def authority user
    self.memberships.where( user: user ).first.authority
  end

end
