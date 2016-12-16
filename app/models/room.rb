class Room < ApplicationRecord
  extend FriendlyId
  friendly_id :screen_name

  validates :screen_name, :room_name, :description, presence: true
  validates :screen_name, friendly_id: true
  validates :screen_name, length: { in: 1..255 }
  validates :screen_name, uniqueness: true
  validates :room_name, length: { in: 2..64 }
  validates :description, length: { in: 1..1000 }
  validates :private, inclusion: {in: [true, false]}

  has_many :messages
  has_many :memberships
  has_many :users,
    ->{ where memberships: { memberable_type: 'User' } },
    { through: :memberships, source: :user, class_name: 'User' }
  has_many :bots,
    -> { where memberships: { memberable_type: 'Bot' } },
    { through: :memberships, source: :bot, class_name: 'Bot' }

  Membership.authorities.each do |k, v|
    association_name = "#{k}_users".to_sym
    has_many association_name,
      ->{ where memberships: { memberable_type: 'User', authority: v } },
      { through: :memberships, source: :user, class_name: 'User' }
  end

  accepts_nested_attributes_for :users

  scope :public_rooms, -> { where private: false }
  scope :private_rooms, -> { where private: true }

  def private?
    private
  end

  def public?
    !private?
  end

  def contains? user
    memberships.where(user: user).limit(1).size > 0
  end

  def chattable? user
    # All members except invited can chat
    [:administer, :maintainer, :member].include? authority(user)
  end

  def authority user
    return nil unless contains? user
    self.memberships.where( user: user ).first.authority.to_sym
  end

  def invited? user
    authority(user) == :invited
  end

  def destroyable? user
    return false unless contains? user
    [:administer].include? authority(user)
  end

  def maintainable? user
    return false unless contains? user
    [:administer, :maintainer].include? authority(user)
  end

  def joinable? user
    # User already joined
    return false if chattable? user

    if private?
      # Only invited user can join to the private room
      return invited? user
    else
      return true
    end
  end

  def leaveable? user
    # User not joined
    return false unless contains? user

    # The last user can't leave from a room
    return false if memberships.size == 1

    case authority user
    when :administer
      # The last administer can't leave from a room
      administer_users.size == 1 ? false : true
    when :maintainer
      true
    when :member
      true
    else
      false
    end
  end

  def bot_addable? user
    [:administer, :maintainer].include? authority(user)
  end

  def kickable? user
    [:administer, :maintainer].include? authority(user)
  end

  def promotable? user, target
    # Can't promote yourself.
    return false if user == target
    return false unless contains? user

    have_authority = case authority user
    when :administer
      [:maintainer, :member].include? authority(target)
    when :maintainer
      [:member].include? authority(target)
    when :member
      false
    else
      false
    end
  end

  def demotable? user, target
    # Can't demote yourself.
    return false if user == target

    case authority user
    when :administer
      [:maintainer].include? authority(target)
    when :maintainer
      false
    when :member
      false
    else
      false
    end
  end

  def invitable? user
    # Anyone can join or be invited on public room
    true if public?

    [:administer, :maintainer].include? authority(user)
  end

  def has_member? user
    users.include? user
  end

  before_validation :bind_default_values

  private
  def bind_default_values
    self.private ||= false
    return
  end
end
