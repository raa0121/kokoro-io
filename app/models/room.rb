class Room < ApplicationRecord

  validates :screen_name, :display_name, :description, presence: true
  validates :screen_name, length: { in: 1..255 }
  validates :screen_name, uniqueness: true
  validates :screen_name, format: {
    with: %r`(?:[a-z0-9_-]+/)?[a-z0-9_-]+`,
    message: 'screen_name only can contain lowser alphabet and digits, and some symbols(-, _ and /). Only one slash can be contained.'
  }
  validates :display_name, length: { in: 2..64 }
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

  has_many :chattable_users,
    -> { where memberships: {memberable_type: 'User', authority: [:administrator, :maintainer, :member]}},
    { through: :memberships, source: :user, class_name: 'User' }

  accepts_nested_attributes_for :users

  scope :public_rooms, -> { where private: false }
  scope :private_rooms, -> { where private: true }

  def group_name
    xs = screen_name.split('/')
    if xs.size == 1
      nil
    else
      xs.first
    end
  end

  def channel_name
    screen_name.split('/').last
  end

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
    [:administrator, :maintainer, :member].include? authority(user)
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
    [:administrator].include? authority(user)
  end

  def maintainable? user
    return false unless contains? user
    [:administrator, :maintainer].include? authority(user)
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
    when :administrator
      # The last administrator can't leave from a room
      administrator_users.size == 1 ? false : true
    when :maintainer
      true
    when :member
      true
    when :invited
      true
    else
      false
    end
  end

  def bot_addable? user
    [:administrator, :maintainer].include? authority(user)
  end

  def kickable? user
    [:administrator, :maintainer].include? authority(user)
  end

  def promotable? user, target
    # Can't promote yourself.
    return false if user == target
    return false unless contains? user

    have_authority = case authority user
    when :administrator
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
    when :administrator
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
    return true if public?

    # Only Administrator or maintainer can invite in provate room
    [:administrator, :maintainer].include? authority(user)
  end

  def has_member? user
    users.include? user
  end

  def archived?
    # TODO: implement archived or not
    false
  end

  before_validation :bind_default_values

  private
  def bind_default_values
    self.private ||= false
    return
  end
end
